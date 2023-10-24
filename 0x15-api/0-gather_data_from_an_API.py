#!/usr/bin/python3
"""Gather data from an API"""

import requests
from sys import argv

if __name__ == "__main__":
    employee_id = argv[1]
    user_url = "https://jsonplaceholder.typicode.com/users/{}".format(employee_id)
    todos_url = "https://jsonplaceholder.typicode.com/todos?userId={}".format(employee_id)

    response_user = requests.get(user_url).json()
    response_todos = requests.get(todos_url).json()

    employee_name = response_user.get('name')
    done_tasks = [task for task in response_todos if task.get('completed')]
    total_tasks = len(response_todos)
    num_done_tasks = len(done_tasks)

    print("Employee {} is done with tasks({}/{}):".format(employee_name, num_done_tasks, total_tasks))
    for task in done_tasks:
        print("\t {}".format(task.get('title')))
