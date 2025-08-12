# Taskwarrior Cheat Sheet

1. **Basic Task Management**:
   - **Add a Task**: `task add "Write project report" due:2025-04-10 priority:H`
     - **Tip**: Always include a due date and priority to help prioritize tasks.
2. **Organizing Tasks**:

   - **Use Projects**: `task add "Design homepage" project:Website`
     - **Tip**: Group related tasks under projects to keep your task list organized.
   - **Tagging**: `task add "Prepare presentation" +work +urgent`
     - **Tip**: Use tags to categorize tasks by context or urgency.

3. **Prioritization**:

   - **Set Priorities**: `task modify 1 priority:M`
     - **Tip**: Regularly review and adjust task priorities to reflect changing priorities.

   - **Change Due Date**: `task modify 1 due:2025-08-15`
     - **Tip**: Modify due dates to adapt to changing deadlines.

   - **Update Tags**: `task modify 1 +urgent -pending`
     - **Tip**: Add or remove tags to keep tasks better organized.

   - **Edit Description**: `task modify 1 description:"Updated task description"`
     - **Tip**: Keep task descriptions accurate and up-to-date.

4. **Recurring Tasks**:

   - **Create Recurring Tasks**: `task add "Weekly team meeting" recur:weekly due:friday`
     - **Tip**: Use recurring tasks for regular activities to ensure they are not forgotten.

5. **Time Tracking**:

   - **Start a Timer**: `task start 1`
   - **Stop a Timer**: `task stop 1`
     - **Tip**: Use time tracking to monitor how long tasks take and improve time management.

6. **Task Dependencies**:

   - **Set Dependencies**: `task add "Submit report" depends:2`
     - **Tip**: Use dependencies to ensure tasks are completed in the correct order.

7. **Marking Tasks as Done**:

   - **Mark a Task as Done**: `task done 1`
     - **Tip**: Use the `done` command to mark tasks as completed and remove them from your active list.
     - **Example**: `task done 3` will mark the task with ID 3 as completed.

   - **Batch Mark Tasks as Done**: `task done 3,5,7`
     - **Tip**: Use commas to mark multiple tasks as done in one command.
     - **Example**: `task done 2,4` will mark the tasks with IDs 2 and 4 as completed.

7. **Custom Reports**:

   - **Generate Reports**: `task report`
     - **Tip**: Customize reports to focus on specific projects, tags, or priorities.

8. **Review and Reflect**:

   - **Daily Review**: `task next`
     - **Tip**: Review your task list daily to plan your day and adjust priorities.
   - **Weekly Review**: `task summary`
     - **Tip**: Conduct a weekly review to assess progress and plan for the upcoming week.

9. **Synchronization**:

   - **Sync Tasks**: `task sync`
     - **Tip**: Use synchronization to keep your tasks updated across multiple devices.

   - **Remote Database Setup**:

     - **Using Remote Database**: Taskwarrior can be configured to use a central, remote Taskserver for synchronization. This allows multiple devices to share and synchronize tasks seamlessly.

### Setting Up a Remote Taskserver

1. **Install Taskserver**:
   - Install Taskserver on a self-hosted server or use a cloud-based service.
     - For Linux users: Install using your package manager (e.g., `sudo apt install taskd`).
     - For macOS users: Install using Homebrew (`brew install taskd`).

2. **Initialize Taskserver**:
   - Create a directory for Taskserver data:
     ```bash
     mkdir -p ~/taskd_data
     taskd init --data ~/taskd_data
     ```

3. **Generate Certificates**:
   - Taskserver requires SSL certificates. Use the `taskdctl` script to generate them:
     ```bash
     cd ~/taskd_data/pki
     ./generate
     ```
   - This will create `client.cert.pem`, `client.key.pem`, and `ca.cert.pem` files for the client.

4. **Configure Taskserver**:
   - Edit the Taskserver configuration file:
     ```bash
     taskd config --data ~/taskd_data --set server.address=0.0.0.0:53589
     taskd config --data ~/taskd_data --set log=/var/log/taskd.log
     ```

5. **Start Taskserver**:
   ```bash
   taskd server --data ~/taskd_data
   ```

6. **Configure Taskwarrior**:
   - Update your `.taskrc` file with the following:
     ```bash
     taskd.server=SERVER_ADDRESS
     taskd.credentials=ORGANIZATION/USERNAME/KEY
     taskd.certificate=/path/to/client.cert.pem
     taskd.key=/path/to/client.key.pem
     taskd.ca=/path/to/ca.cert.pem
     ```

### Hosting Options

You can self-host Taskserver on your own server or use the following services:

- **DigitalOcean**: Provides affordable cloud servers for self-hosting.
- **AWS EC2**: Offers scalable options for hosting Taskserver.
- **Linode**: Another popular choice for hosting servers.
- **Taskserver Hosting by Third Parties**: Some providers offer ready-made Taskserver hosting solutions.

### Practical Examples

1. **Meeting Preparation**:
   - Add a Task: `task add "Prepare slides for meeting" project:Work due:2025-08-15 +presentation`
   - Mark as Done: `task done 1`
   - Update Priority: `task modify 1 priority:H`

2. **Personal Errands**:
   - Add a Task: `task add "Buy groceries" project:Personal due:2025-08-12 +shopping`
   - Update Tags: `task modify 2 +urgent`
   - Mark as Done: `task done 2`

3. **Team Collaboration**:
   - Add a Task: `task add "Review team report" project:Team due:2025-08-20 +review`
   - Set Dependencies: `task modify 3 depends:1`
   - Track Time: `task start 3`, `task stop 3`

By leveraging these examples, users can manage both personal and professional tasks efficiently.

10. **Automation and Scripting**:

    - **Automate Tasks**: Use scripts to automate repetitive task management actions.
    - **Tip**: Integrate Taskwarrior with other tools using scripts to streamline workflows.

11. **Use Aliases**:

    - **Create Aliases**: `alias t='task'`
    - **Tip**: Use shell aliases to shorten common Taskwarrior commands for efficiency.

12. **Stay Updated**:
    - **Regular Updates**: Keep Taskwarrior updated to benefit from new features and improvements.

By following these examples and best practices, you can effectively manage your tasks with Taskwarrior, ensuring that you stay organized, prioritize effectively, and maintain productivity.

s3 sync

```
man task-sync
```
