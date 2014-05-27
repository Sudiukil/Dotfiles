#!/bin/sh

case $1 in
	-a)
		taskId=`tail -n 1 ~/.tasks | cut -b 2,3,4`
		
		if test -z $taskId
		then
			taskId="0"
		fi

		taskId=`echo "$taskId+1" | bc -l`
		
		if test $taskId -lt 10
		then
			taskId="00$taskId"
		elif test $taskId -ge 10 -a $taskId -lt 100
		then
			taskId="0$taskId"
		elif test $taskId -gt 999
		then
			echo "Erreur : nombre de tâches maximum atteint"
			exit 1
		fi

		task="[$taskId] [`date '+%d/%m/%y'`] $2"

		echo $task >> ~/.tasks
		echo "Tâche \"$2\" d'id $taskId ajoutée."
		exit 0;;
	-d)
		taskId=$2

		if test $taskId -lt 10 -a ${#taskId} -lt 3
		then
			taskId="00$taskId"
		elif test $taskId -ge 10 -a $taskId -lt 100 -a ${#taskId} -lt 3
		then
			taskId="0$taskId"
		fi

		if ! grep "\[$taskId\]" ~/.tasks > /dev/null
		then
			echo "Erreur : Tâche d'id $taskId inexistante."
			exit 1
		fi

		taskLabel=`grep "\[$taskId\]" ~/.tasks | cut -b 18-`

		read -p "Supprimer la tâche \"$taskLabel\" d'id $taskId ? [o/N] " ans
		case $ans in
			o|O)
				sed -e "/\[$taskId\]/d" -i ~/.tasks
				echo "Tâche \"$taskLabel\" d'id $taskId supprimée."
				exit 0;;
			*)
				exit 1;;
		esac;;
	-m)
		taskId=$2
		newTaskLabel=$3

		if test $taskId -lt 10 -a ${#taskId} -lt 3
		then
			taskId="00$taskId"
		elif test $taskId -ge 10 -a $taskId -lt 100 -a ${#taskId} -lt 3
		then
			taskId="0$taskId"
		fi

		if ! grep "\[$taskId\]" ~/.tasks > /dev/null
		then
			echo "Erreur : Tâche d'id $taskId inexistante."
			exit 1
		fi

		taskLabel=`grep "\[$taskId\]" ~/.tasks | cut -b 18-`

		sed -e "s/$taskLabel/$newTaskLabel/g" -i ~/.tasks
		echo "Tâche \"$taskLabel\" d'id $taskId changée en \"$newTaskLabel\"."
		exit 0;;
	-p)
		echo -e "----- Tâches -----\n"
		cat ~/.tasks
		echo -e "\n----- ~ -----"
		exit 0;;

	--purge)
		read -p "Supprimer toutes les tâches ? [o/N] " ans
		case $ans in
			o|O)
				cat /dev/null > ~/.tasks
				cat /dev/null > ~/.tasksbkp
				echo "Toutes les tâches ont été supprimées."
				exit 0;;
			*)
				exit 1;;
		esac;;
	'')
		tasks -p
		exit 0;;
	*)
		echo -e "Usage:\n"
		echo -e "-a \"<nom>\"\t\tAjouter une tâche"
		echo -e "-d <id>\t\t\tSupprimer une tâche"
		echo -e "-m <id> \"<nom>\"\t\tRenommer une tâche"
		echo -e "-p\t\t\tAfficher toutes les tâches"
		echo -e "--purge\t\t\tSupprimer toutes les tâches"
		exit 0;;
esac
