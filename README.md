
# Server Performance Stats

## About the Project
Server Performance Stats is a beginner-friendly DevOps project
developed using Windows PowerShell.

It collects basic system performance information and displays
a report in the terminal. It also automatically saves each
report as a text file for future reference.

## Features
- Displays CPU usage.
- Displays total, used, and free RAM.
- Shows disk space for local drives.
- Automatically saves reports in a reports folder.
- Adds a timestamp to each report filename.

## Technologies Used
- Windows PowerShell
- Windows Management Instrumentation (CIM)
- Git and GitHub (for version control)

## Project Structure

server-performance-stats/
├── server_stats.ps1
├── README.md
└── reports/
    └── performance_<timestamp>.txt

## How to Run

1. Download or clone this repository.
2. Open PowerShell in the project folder.
3. Run the following command:

   .\server_stats.ps1

4. View the performance report in the terminal.
5. Open the reports folder to view saved reports.

## Sample Output

CPU Usage: 63%
Total RAM: 5.92 GB
Used RAM: 4.86 GB
Free RAM: 1.06 GB

Drive: C:
Total Space: 475.78 GB
Used Space: 353.84 GB
Free Space: 121.94 GB

## Learning Outcomes
- Learned to retrieve system information using PowerShell.
- Practiced variables, loops, and file handling.
- Learned to generate timestamped reports.
- Understood the basics of system performance monitoring.

## Future Improvements
- Add continuous monitoring.
- Set alerts when CPU or memory usage is high.
- Generate reports in CSV format.
