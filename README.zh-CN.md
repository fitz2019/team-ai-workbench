# Team AI Workbench

团队级 AI 协作工作台源仓库。

[English](./README.md) | 简体中文

## 这是什么

`team-ai-workbench` 是一个**团队共享的 AI 工作台源仓库**。

它解决的不是“某个人怎么写 prompt”，而是：

- 多个项目怎么共享一套 AI 协作方式
- 后端、前端、产品、QA、运维怎么按角色接入
- 新项目怎么快速落一套规则、角色和模板
- 团队经验怎么沉淀成可复用资产

它**不是业务仓库**。  
它是你们团队真正的上游工作台仓库，具体业务项目从这里初始化出来。

## 先怎么用

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

### 3. 补项目自己的真相

初始化后，优先补这个文件：

- `.agents/project-specific.md`

至少补清楚：

- 真实命令
- 业务词汇
- 权限 / 边界 / 多租户规则
- 发布 / 回滚 / 兼容性约束

### 4. 进入项目目录启动 Codex

```powershell
codex
```

第一轮建议只做小任务：

- 只读架构分析
- 窄范围 bug 分析
- 一次小改动 + 局部验证

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
core/
roles/
advanced/
templates/
scripts/
docs/
```

- `core/`
  所有角色都共用的基线规则、运行层、共享 skill 和 agent
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

## 致谢

这套 workbench 的很多思路和部分能力来源，都参考了 [ECC](https://github.com/affaan-m/ECC)。  
我们的做法不是原样照搬，而是把 ECC 作为上游能力源和结构参考，再结合我们自己的工程规范，整理成更适合团队长期落地和维护的版本。

## 文档入口

- [模板目录](./docs/template-catalog.md)
- [团队接入指南](./docs/adoption-guide.md)
- [项目接入指南](./docs/project-integration-guide.md)
- [项目知识沉淀指南](./docs/knowledge-capture-guide.md)
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
