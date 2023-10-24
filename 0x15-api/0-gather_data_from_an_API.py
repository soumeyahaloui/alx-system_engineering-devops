#!/usr/bin/python3
"""Gather data from an API"""

import requests
from sys import argv


def fetch_employee_todo(employee_id):
    user_url = f"https://jsonplaceholder.typicode.com/users/{employee_id}"
    todos_url = f"https://jsonplaceholder.typicode.com/todos?userId={employee_id}"

    response_user = requests.get(user_url).json()
    response_todos = requests.get(todos_url).json()

    employee_name = response_user.get('name')
    done_tasks = [task for task in response_todos if task.get('completed')]
    total_tasks = len(response_todos)
    num_done_tasks = len(done_tasks)

    print(f"Employee {employee_name} is done with tasks({num_done_tasks}/{total_tasks}):")
    for task in done_tasks:
        print(f"\t{task.get('title')}")


if __name__ == "__main__":
    if len(argv) != 2:
        print("Usage: python3 0-gather_data_from_an_API.py <employee_id>")
    else:
        fetch_employee_todo(int(argv[1]))
