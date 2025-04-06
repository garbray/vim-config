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

10. **Automation and Scripting**:

    - **Automate Tasks**: Use scripts to automate repetitive task management actions.
    - **Tip**: Integrate Taskwarrior with other tools using scripts to streamline workflows.

11. **Use Aliases**:

    - **Create Aliases**: `alias t='task'`
    - **Tip**: Use shell aliases to shorten common Taskwarrior commands for efficiency.

12. **Stay Updated**:
    - **Regular Updates**: Keep Taskwarrior updated to benefit from new features and improvements.

By following these examples and best practices, you can effectively manage your tasks with Taskwarrior, ensuring that you stay organized, prioritize effectively, and maintain productivity.
