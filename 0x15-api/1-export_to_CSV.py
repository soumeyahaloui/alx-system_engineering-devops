#!/usr/bin/python3
"""Gather data from an API and export to CSV"""

import csv
import requests
from sys import argv


def fetch_and_export_to_csv(employee_id):
    user_url = f"https://jsonplaceholder.typicode.com/users/{employee_id}"
    todos_url = f"https://jsonplaceholder.typicode.com/todos?userId={employee_id}"

    response_user = requests.get(user_url).json()
    response_todos = requests.get(todos_url).json()

    employee_name = response_user.get('username')

    csv_filename = f"{employee_id}.csv"
    with open(csv_filename, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        csv_writer.writerow(["USER_ID", "USERNAME", "TASK_COMPLETED_STATUS", "TASK_TITLE"])

        for task in response_todos:
            task_completed_status = "True" if task.get('completed') else "False"
            task_title = task.get('title')
            csv_writer.writerow([employee_id, employee_name, task_completed_status, task_title])

    print(f"Data exported to {csv_filename}")


if __name__ == "__main__":
    if len(argv) != 2:
        print("Usage: python3 1-export_to_CSV.py <employee_id>")
    else:
        fetch_and_export_to_csv(int(argv[1]))
