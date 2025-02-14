# Smoking Cessation Plan Implementation - Actionable Steps

This document outlines the key steps for implementing the smoking cessation plan feature.

## 1. Database (PocketBase - `plans` collection)

*   **Schema:** `id`, `user_id`, `start_date`, `target_date`, `initial_cigarettes_per_day`, `reduction_interval`, `reduction_amount`. (Foreign key: `user_id` references `users(id)`)

## 2. Plan Service (`lib/services/plan_service.dart`)

*   **Methods:**
    *   `getPlan(userId)`: Retrieves user's plan (returns `null` if none).
    *   `createPlan(...)`: Creates a new plan.
    *   `updatePlan(...)`: Updates an existing plan.

## 3. Plan Page (`lib/pages/plan_page.dart`)

*   **UI:**
    *   **Plan Exists:** Display plan details (Start Date, Target Date, Initial Cigarettes, Reduction Interval, Reduction Amount, Update button).
    *   **No Plan:** Form to create a plan (Date pickers for dates, number inputs for quantities, Save button).

*   **Logic:**
    *   Inject `PlanService`.
    *   Load plan on page load (`getPlan`).
    *   Display appropriate UI (details or form).
    *   Handle loading/error states.
    *   Form validation.

## 4. Integration

*   `HomePage` button navigates to `/plan`.

## 5. Future Enhancements

*   Plan Visualization.
*   Dynamic Updates.
*   Notifications/Reminders.

## 6. Chat Page Layout (`lib/pages/chat_page.dart`)

*   **Top App Bar:** Title ("你是哪个？") and a back button.
*   **Message Bubbles:**
    *   User messages: Right-aligned, light blue background.
    *   AI messages: Left-aligned, white background.
*   **Input Field:** Text input at the bottom.
*   **Send Button:**  Next to the input field.
*   **Bottom Buttons:** "深度思考 (R1)" and "联网搜索".
* **Error Handling**: Display error messages such as "服务器繁忙，请稍后再试。"
