import type { TaskModel } from "../../models/TaskModel";

export const TaskActionType = {
    START_TASK: "START_TASK",
    INTERRUPT_TASK: "INTERRUPT_TASK",
    RESET_STATE: "RESET_STATE",
    COUNT_DOWN: "COUNT_DOWN",
    COMPLETE_TASK: "COMPLETE_TASK",
} as const;

export type TaskActionsWithPayload =
  | {
      type: (typeof TaskActionType)["START_TASK"];
      payload: TaskModel;
    }
  | {
      type: (typeof TaskActionType)["COUNT_DOWN"];
      payload: { secondsRemaining: number };
    };

export type TaskActionsWithoutPayload =
  | {
      type: (typeof TaskActionType)["RESET_STATE"];
    }
  | {
      type: (typeof TaskActionType)["INTERRUPT_TASK"];
    }
  | {
      type: (typeof TaskActionType)["COMPLETE_TASK"];
    };

export type TaskActionModel =
  | TaskActionsWithPayload
  | TaskActionsWithoutPayload;