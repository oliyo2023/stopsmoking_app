# 戒烟计划流程重设实施计划

**目标：**

根据 `plan_new.md` 文件中的内容，重新设置戒烟计划流程。

**计划：**

1.  **创建新的模型类：** 创建一个新的模型类 `SmokingInfo`，用于存储用户提供的基本信息，例如烟龄、每日吸烟量和香烟品牌及单价。
2.  **修改 `PlanController`：**
    *   添加 `SmokingInfo` 类型的变量，用于存储用户提供的基本信息。
    *   添加方法 `collectSmokingInfo`，用于收集用户提供的基本信息，并计算经济影响、购买力对比和健康影响评估。
    *   添加方法 `predictQuittingBenefits`，用于预测戒烟收益。
    *   修改 `startPlan` 方法，使其能够根据用户提供的基本信息来初始化计划进度。
    *   添加方法 `getSmokingInfo`，用于获取用户提供的基本信息。
3.  **修改 `PlanPage`：**
    *   添加表单，用于收集用户提供的基本信息。
    *   在 `PlanPage` 中调用 `PlanController` 的 `collectSmokingInfo` 方法，将用户提供的信息传递给 `PlanController`。
    *   显示经济影响、购买力对比、健康影响评估和戒烟收益预测的结果。
4.  **修改 `PlanProvider`：**
    *   添加方法 `saveSmokingInfo`，用于将用户提供的基本信息保存到本地存储或数据库中。
    *   添加方法 `getSmokingInfo`，用于从本地存储或数据库中获取用户提供的基本信息。