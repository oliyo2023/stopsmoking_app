# 戒烟计划功能实现方案 (与DeepSeek合作)

本文档概述了在戒烟应用程序中实现戒烟计划功能的方案。

## 1. 数据库结构

计划数据存储在 PocketBase 的 `plans` 集合中。架构如下：

```sql
CREATE TABLE plans (
    id TEXT PRIMARY KEY NOT NULL,
    user_id TEXT NOT NULL,
    start_date TEXT NOT NULL,
    target_date TEXT NOT NULL,
    initial_cigarettes_per_day INTEGER NOT NULL,
    reduction_interval INTEGER NOT NULL,
    reduction_amount INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

## 2. 计划服务 (Plan Service)

创建 `PlanService` (`lib/services/plan_service.dart`) 来处理与 `plans` 集合的交互。

**方法：**

*   `getPlan(String userId)`: 获取用户的计划。如果计划不存在，则返回 `null`。
*   `createPlan(...)`: 创建新计划。将所有计划参数作为输入。
*   `updatePlan(...)`: 更新现有计划。将计划 ID 和更新的参数作为输入。

## 3. 计划页面 (Plan Page)

实现 `PlanPage` (`lib/pages/plan_page.dart`)。

**UI:**

*   **如果计划存在：** 显示计划详细信息：
    *   开始日期 (Start Date)
    *   目标日期 (Target Date)
    *   每日初始吸烟量 (Initial Cigarettes Per Day)
    *   减少间隔 (Reduction Interval)
    *   减少量 (Reduction Amount)
    *   更新计划的按钮（链接到与计划创建相同的表单，预填当前值）。

*   **如果计划不存在：** 显示创建新计划的表单：
    *   开始日期和目标日期的文本字段（使用日期选择器）。
    *   每日初始吸烟量、减少间隔和减少量的数字输入字段。
    *   保存新计划的按钮。

**逻辑：**

1.  使用 `Get.put()` 或 `Get.find()` 注入 `PlanService`。
2.  在页面加载时，调用 `PlanService.getPlan(userId)` 获取用户的计划。
3.  根据结果，显示计划详细信息或创建表单。
4.  适当地处理加载和错误状态（显示加载指示器和错误消息）。
5.  实现计划创建和更新的表单验证。

## 4. 集成

*   确保 `HomePage` 上的“查看戒烟计划”按钮正确导航到 `/plan`。

## 5. 潜在增强功能（未来）

*   **计划可视化：** 显示图表或图形以可视化计划的进度。
*   **动态更新：** 根据打卡数据自动更新计划。
*   **通知/提醒：** 发送通知以提醒用户他们的计划。