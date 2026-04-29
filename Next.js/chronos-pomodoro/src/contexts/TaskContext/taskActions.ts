import type { TaskModel } from "../../models/TaskModel";

export const TaskActionType = {
    START_TASK: "START_TASK",
    INTERRUPT_TASK: "INTERRUPT_TASK",
} as const;

export type TaskActionType = (typeof TaskActionType)[keyof typeof TaskActionType];

export type TaskActionModel =
  | {
      type: typeof TaskActionType.START_TASK;
      payload: TaskModel;
    }
  | {
      type: typeof TaskActionType.INTERRUPT_TASK;
    };

// 5:46