# 戒烟计划步骤介入方案 (调整后)

**1. 数据模型设计**

*   **PlanStage (计划阶段)**:
    *   `name`: 阶段名称 (例如：准备期, 戒断期, 巩固期)
    *   `durationDays`: 阶段持续天数
    *   `tasks`:  List<String>，阶段性任务列表
*   **PlanProgress (计划进度)**:
    *   `stage`: 当前所处阶段 (PlanStage)
    *   `startDate`: 计划开始日期
    *   `dailyCheckIn`: Map<DateTime, bool>，每日签到记录 (日期 -> 是否签到)
    *   `symptomRecords`: List<SymptomRecord>，症状记录列表
*   **SymptomRecord (症状记录)**:
    *   `dateTime`: 记录时间
    *   `symptom`: 症状描述
    *   `copingStrategy`: 应对策略

**2. Provider 层创建 (lib/providers/plan_provider.dart)**

*   创建 `PlanProvider`，用于管理计划相关数据，并与 PocketBase 服务交互。
*   在 `PlanProvider` 中添加 API 方法：
    *   `getPlanStages()`:  从 PocketBase 获取预设的计划阶段配置 (List<PlanStage>)
    *   `saveSymptomRecord(SymptomRecord record)`:  将症状记录保存到 PocketBase

**3. 服务层简化 (lib/services/pocketbase_service.dart)**

*   `PocketBaseService` 仅负责 PocketBase 客户端的初始化和通用配置，**不再直接处理计划相关的数据请求**。
*   `PlanProvider` 将直接使用 `PocketBaseService` 提供的客户端实例进行数据交互。

**4. 控制器调整 (lib/controllers/plan_controller.dart)**

*   `PlanController` 依赖 `PlanProvider` 获取和操作数据。
*   在 `PlanController` 中调用 `PlanProvider` 的方法，例如 `PlanProvider.getPlanStages()` 来获取计划阶段数据。
*   状态管理逻辑保持不变：
    *   `currentStage`: 当前阶段 (Rx<PlanStage>)
    *   `planProgress`: 计划进度 (Rx<PlanProgress>)
    *   `dailyTasks`:  RxList<String>，当前阶段每日任务列表
*   方法逻辑保持不变，但数据获取和存储操作委托给 `PlanProvider`。

**5. UI 组件开发 (lib/widgets 目录)**

*   `StageTimeline`:  阶段时间轴组件
*   `InteractiveCalendar`:  交互式日历组件
*   `SymptomRecordForm`:  症状记录表单

**6. 页面集成 (lib/pages/plan_page.dart)**

*   在 `PlanPage` 中集成 UI 组件，并连接 `PlanController` 和 `PlanProvider`。

**7. 路由配置 (lib/app_routes.dart)**

*   确保 `PlanPage` 路由配置正确。

**8. 主题样式适配 (lib/theme/app_theme.dart)**

*   适配新增组件样式。

**9. 多语言支持**

*   预留文本国际化处理。

**调整后的实施计划:**

1.  **创建数据模型文件** (`lib/models/plan_models.dart`)，定义 `PlanStage`, `PlanProgress`, `SymptomRecord` 类。
2.  **创建 `PlanProvider`** (`lib/providers/plan_provider.dart`)，并将 PocketBase 交互逻辑移入，简化 `PocketBaseService`。
3.  **调整 `PlanController`**，使用 `PlanProvider` 获取数据。
4.  **创建 UI 组件**，并在 `PlanPage` 中集成。
5.  **测试和调整**，确保功能完整和用户体验良好。

您看这样调整可以吗？如果没问题，我可以请求您切换到 code 模式，开始进行代码开发。
