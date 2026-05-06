import type { TaskStateModel } from "../../models/TaskStateModel";
import { exportSecondsToMinutes } from "../../utils/formatSecondsToMinutes";
import { getNextCycle } from "../../utils/getNextCycle";
import { TaskActionType, type TaskActionModel } from "./taskActions";

export function taskReducer(
  state: TaskStateModel,
  action: TaskActionModel,
): TaskStateModel {
  switch (action.type) {
    case TaskActionType.START_TASK: {
      const newTask = action.payload;
      const nextCycle = getNextCycle(state.currentCycle);
      const secondsRemaining = newTask.duration * 60;
      
      return {
        ...state,
        activeTask: newTask,
        currentCycle: nextCycle,
        secondsRemaining,
        formattedSecondsRemaining: exportSecondsToMinutes(secondsRemaining),
        tasks: [...state.tasks, newTask],
      };
    };
    case TaskActionType.INTERRUPT_TASK:
        return {
                ...state,
                activeTask: null,
                secondsRemaining: 0,
                formattedSecondsRemaining: '00:00',
                tasks: state.tasks.map((task) => {
                    if (task.id === state.activeTask?.id) {
                        return {
                            ...task,
                            interruptedDate: Date.now(),
                        };
                    }

                    return task;
                }),};
    case TaskActionType.RESET_STATE:
        return state;
    case TaskActionType.COUNT_DOWN:
        return {
            ...state,
            secondsRemaining: action.payload.secondsRemaining,
            formattedSecondsRemaining: exportSecondsToMinutes(action.payload.secondsRemaining),
        };
    case TaskActionType.COMPLETE_TASK:
        return {
                ...state,
                activeTask: null,
                secondsRemaining: 0,
                formattedSecondsRemaining: '00:00',
                tasks: state.tasks.map((task) => {
                    if (task.id === state.activeTask?.id) {
                        return {
                            ...task,
                            completedDate: Date.now(),
                        };
                    }

                    return task;
                }),};
    default:
      return state;
  }
}
