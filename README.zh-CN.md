# Team AI Workbench

团队级 AI 协作工作台源仓库。

[English](./README.md) | 简体中文

## 这是什么

`team-ai-workbench` 是一个**团队共享的 Codex harness 工作台源仓库**。

它解决的不是“某个人怎么写 prompt”，而是：

- 怎么把 Codex 运行成一套可控的长任务工作流
- 怎么用 hook、evaluator、handoff、默认失败验证，把长任务从“凭感觉跑”变成“有流程地跑”
- 多个项目怎么共享一套 AI 协作方式
- 怎么共享一套编码纪律：先澄清、再编码，优先简单解法，控制改动范围，并用明确验证标准收口
- 后端、前端、产品、QA、运维怎么按角色接入
- 新项目怎么快速落一套规则、角色和模板
- 团队经验怎么沉淀成可复用资产

它**不是业务仓库**。  
它是你们团队真正的上游 Codex harness 仓库，具体业务项目从这里初始化出来。

一句话：

> `codex-harness/` 负责把 Codex 跑成稳定工作流；
> `core/roles/templates` 负责提供团队规则、角色思考和项目模板。

## 先怎么用

这不是要放进业务代码里的依赖包。团队成员的使用方式是：

1. 先 clone 这个 workbench 母仓库
2. 用初始化脚本把规则、角色、skills、harness 安装到自己的业务项目
3. 进入业务项目根目录启动 Codex
4. 后续项目知识留在业务项目里，通用经验再回灌到这个 workbench

### 0. 克隆 workbench 母仓库

```powershell
cd C:\software\self\project
git clone https://github.com/fitz2019/team-ai-workbench.git
cd team-ai-workbench
```

如果本机已经 clone 过，后续只需要在这个目录里拉最新版本：

```powershell
git pull
```

### 1. 先选模板

如果仓库类型很明确，优先直接用模板：

| 仓库类型 | 推荐模板 |
| --- | --- |
| Go API / worker / 后端服务 | `go-service` |
| React / Next.js 前端项目 | `web-frontend` |
| 产品需求 / capability / 研究仓库 | `product-docs` |
| QA / 回归 / 浏览器验证仓库 | `qa-project` |
| 产品 + QA 联动交付仓库 | `feature-delivery` |
| CI/CD / 基础设施 / 运维仓库 | `ops-service` |

### 2. 初始化项目

把 `C:\path\to\repo` 换成真实业务项目路径：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template go-service
```

例子：

```powershell
# Go 后端服务
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template go-service

# 前端产品仓库
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template web-frontend

# 产品 + QA 联动仓库
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template feature-delivery
```

初始化完成后，目标业务项目会得到这些内容：

| 路径 | 作用 |
| --- | --- |
| `AGENTS.md` | 项目根入口，告诉 Codex 当前项目应该遵守哪些协作规则 |
| `.agents/` | 团队规则、角色约束、项目事实、沉淀后的稳定知识 |
| `.codex/` | Codex 配置、subagent、hooks、默认扫描的 skills |
| `.ai-harness/` | 长任务计划、执行进度、验证证据、暂停和续跑控制 |

### 3. 补项目自己的真相

初始化后，优先补这个文件：

- `.agents/project-specific.md`

至少补清楚：

- 真实命令
- 业务词汇
- 权限 / 边界 / 多租户规则
- 发布 / 回滚 / 兼容性约束

同时你会看到一套 harness 运行时文件：

- `.codex/`：Codex 配置、subagent、hooks
- `.agents/`：团队规则和角色约束
- `.ai-harness/`：长任务计划、进度、验证证据、转向信息

### 4. 进入项目目录启动 Codex

注意是在**业务项目根目录**启动，不是在 `team-ai-workbench` 目录启动：

```powershell
cd C:\path\to\repo
```

```powershell
codex
```

第一次进入项目后，先确认项目是否已经被 Codex 信任。不同入口处理方式不一样：

- Codex CLI 交互界面：如果提示 hook 需要 review，再输入 `/hooks` 查看并信任项目 hook
- Codex 桌面客户端：按客户端里的项目 / hook 信任提示处理；如果没有提示，不需要手动执行 `/hooks`
- 如果项目 hook 没有被信任，长任务 harness 里的 stop gate、steering、evaluator 触发可能不会生效

第一轮建议只做小任务：

- 只读架构分析
- 窄范围 bug 分析
- 一次小改动 + 局部验证

### 5. 平时开发怎么用

短任务不用开 harness，直接在业务项目里让 Codex 按项目规则工作：

```text
阅读当前项目规则和相关代码，先给我分析这个 bug 的根因，不要改代码。
```

```text
基于当前项目规则，帮我实现这个小需求。改动范围尽量收窄，完成后跑必要验证。
```

```text
请以 reviewer 视角检查这次改动，重点看行为回归、边界条件和缺失测试。
```

### 6. 启用长任务模式

只有当你要让 Codex 跑一个持续多轮的任务时，才启用：

先写清楚计划：

```powershell
notepad .\.ai-harness\BUILD_PLAN.md
```

再开启 harness：

```powershell
New-Item -ItemType File .\.ai-harness\ACTIVE -Force
```

如果你希望每轮结束后，验证没过时继续自动推进：

```powershell
New-Item -ItemType File .\.ai-harness\CONTINUE_ON_STOP -Force
```

需要暂停时：

```powershell
New-Item -ItemType File .\.ai-harness\AGENT_STOP -Force
```

然后在 Codex 里明确说：

```text
按 .ai-harness/BUILD_PLAN.md 执行。每轮更新 PROGRESS.md、EVIDENCE.md 和 HANDOFF.md；验证不过不要假装完成。
```

### 7. 项目知识怎么沉淀

业务项目里的知识分两层：

| 放哪里 | 适合沉淀什么 |
| --- | --- |
| `.agents/project-specific.md` | 稳定、确定、以后 Codex 每次都应该知道的项目事实 |
| `docs/knowledge/` | 聊天复盘、经验草稿、问题记录、候选规则、待验证知识 |

原则是：

- 当前项目专属的事实，留在业务项目
- 已经被多次验证、对多个项目都有价值的经验，回灌到 `team-ai-workbench`
- 不要把某个业务项目的表名、接口名、客户名直接写进通用规则

## 它的价值是什么

如果没有这套工作台，团队通常会遇到这些问题：

- AI 使用方式全靠个人经验
- 项目之间重复搭规则
- 新人接项目时无法复用已有经验
- 角色很多，但没有统一协作方式
- 规则写了，但没有脚手架和接入路径

这套仓库的价值是把 AI 协作变成：

- 有基线
- 有角色
- 有模板
- 有 harness
- 有长任务 handoff
- 有独立 evaluator
- 有升级路径
- 有治理文档

也就是把“个人技巧”升级成“团队基础设施”。

## 角色层

当前已经成熟可用的角色包：

| 角色 | 适用场景 |
| --- | --- |
| `backend` | Go 服务、API、worker、DB/Redis/MQ 重度后端 |
| `frontend` | React/Next.js、前端构建、可访问性、UI 评审 |
| `product` | 需求澄清、capability 定义、研究、规划 |
| `qa` | 回归、浏览器验证、E2E、发布信心判断 |
| `devops` | 发布、CI/CD、基础设施、网络与运维排障 |

如果仓库类型明确，优先用模板。  
如果需要特殊组合，再按角色拼装。

## 仓库分层

```text
codex-harness/
core/
roles/
advanced/
templates/
scripts/
docs/
```

- `codex-harness/`
  主运行层。对标 cwc 的 harness 架构，提供 `.codex` 配置、hooks、evaluator、handoff 文件和 `.ai-harness` 运行时状态
- `core/`
  所有角色都共用的基线规则、共享 skill 和 agent
- `roles/`
  各角色自己的 overlay
- `advanced/`
  进阶工作流层，默认不启用
- `templates/`
  初始化模板和 starter files
- `scripts/`
  初始化脚本和后续辅助脚本
- `docs/`
  接入、治理、升级、路线图等文档

## 为什么不是直接用 ECC

因为 ECC 更像是**上游大仓库**，而不是你们团队日常直接消费的成品仓库。

上游参考项目：

- [ECC by affaan-m](https://github.com/affaan-m/ECC)

我们现在的做法是：

- 把 ECC 当能力源
- 把 ECC 当结构参考
- 从 ECC 里筛选适合你们团队的 skill / agent / workflow
- 再结合你们自己的工程规范，沉淀成更适合团队日常落地的工作台

一句话说：

> 我们不是不用 ECC，而是不直接原样使用。  
> 我们把 ECC 当能力源，再结合我们自己的工程规范，沉淀成更适合团队日常落地的工作台。

## 为什么参考 cwc

[anthropics/cwc-long-running-agents](https://github.com/anthropics/cwc-long-running-agents) 给了一个很重要的方向：AI coding 下一阶段不只是 prompt 或 skill，而是**可控的 agent harness**。

我们吸收的是它的架构思想：

- 默认失败，直到有证据
- fresh-context evaluator 独立评估
- handoff 文件让长任务可以恢复
- hook 处理 kill switch、steering 和 stop gate

但我们没有把团队规范塞进 cwc 原仓库，而是把 `team-ai-workbench` 改造成 Codex 版本的 harness 架构：`codex-harness/` 跑流程，`.agents/` 和角色包提供运行时约束。

## 致谢

这套 workbench 的很多思路和部分能力来源，都参考了 [ECC](https://github.com/affaan-m/ECC)。  
我们的做法不是原样照搬，而是把 ECC 作为上游能力源和结构参考，再结合我们自己的工程规范，整理成更适合团队长期落地和维护的版本。

长任务 harness 架构参考了 [anthropics/cwc-long-running-agents](https://github.com/anthropics/cwc-long-running-agents)。我们做的是 Codex 本地化改造，不是 vendor 原项目。

同时，`core` 里的共享编码纪律也参考了 [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) 这类思路，但我们没有直接原样落，而是按团队工作台的结构做了本地化改造。

## 文档入口

- [模板目录](./docs/template-catalog.md)
- [团队接入指南](./docs/adoption-guide.md)
- [项目接入指南](./docs/project-integration-guide.md)
- [项目知识沉淀指南](./docs/knowledge-capture-guide.md)
- [Harness 架构说明](./docs/harness-architecture.md)
- [本地回灌流程](./docs/local-backport-playbook.md)
- [角色矩阵](./docs/role-matrix.md)
- [ECC 候选资产映射](./docs/ecc-role-candidate-map.md)
- [抽取审计](./docs/extraction-audit.md)
- [版本策略](./docs/versioning-strategy.md)
- [贡献指南](./docs/contribution-guide.md)
- [升级手册](./docs/upgrade-playbook.md)
- [路线图](./docs/roadmap.md)
- [变更记录](./CHANGELOG.md)

## 进阶层说明

`advanced/` 默认不跟项目一起落。

只有当团队明确需要这些更重的工作方式时再开：

- 正式实施计划
- 子 agent 驱动执行
- 并行调查
- worktree 隔离工作流

不要因为“看起来很强”就默认启用。

## 建议接入顺序

对大多数团队，最稳的顺序是：

1. 先挑一个真实项目
2. 直接选模板，不要先自定义组合
3. 用真实任务跑起来
4. 只把真正复用得上的东西回灌到这个仓库
5. 再扩到更多仓库和更重的工作流
