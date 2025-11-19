# DBESS-Arbitrage: Economic Operation of Distributed Battery Energy Storage Systems

_Reinforcement-learning-based arbitrage strategy for distributed battery energy storage under real-time electricity prices._

---

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Mathematical Model](#mathematical-model)
  - [Objective](#objective)
  - [Constraints](#constraints)
  - [Reinforcement Learning Formulation](#reinforcement-learning-formulation)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Quick Start](#quick-start)
- [Reproducing the Case Studies](#reproducing-the-case-studies)
- [Visualization Tips](#visualization-tips)
- [Possible Extensions](#possible-extensions)
- [Contact](#contact)

---

## Overview

This repository implements an **economic operation strategy** for a **Distributed Battery Energy Storage System (DBESS)** participating in electricity markets.  
The goal is to exploit the **arbitrage potential** of batteries by learning **charge/discharge policies** that react optimally to **real-time (or time-of-use) electricity prices**.

Instead of solving a separate optimization problem at every time step, this project uses **model-free reinforcement learning (RL)** to obtain a **self-optimizing control policy** that:

- Learns the pattern of electricity prices (e.g., daily periodicity);
- Automatically captures the **“charge-low, discharge-high”** behavior;
- Accounts for **capacity constraints**, **power limits**, **operating cost**, and **battery aging cost**.

The mathematical formulation and case-study design are documented in:

> `DBESS模型建立与求解.pdf` (Modeling and Solution of DBESS)

---

## Key Features

- **Physics-informed arbitrage model**
  - Explicit modeling of power limits, state-of-charge (SOC) dynamics, round-trip efficiency, and aging cost.
- **Model-free self-optimization**
  - Uses **Q-learning** to learn the optimal charge/discharge policy without an explicit price forecast model.
- **Multiple case studies**
  - Single DBESS arbitrage behavior under a daily price profile;
  - Impact of different aging levels;
  - Impact of different initial SOC;
  - Comparison with **Simulated Annealing (SA)**;
  - Generalization to perturbed price profiles over multiple days.
- **MATLAB live scripts (`.mlx`)**
  - Reproducible examples with ready-to-run visualization scripts.

---

## Mathematical Model

### Objective

For each DBESS, the operator chooses a charging/discharging power trajectory $P_t$ over a horizon $t = 1, \dots, T$ to **maximize the cumulative economic profit**:

- Revenue from energy arbitrage under real-time (or time-of-use) prices;
- Minus charging/discharging losses;
- Minus **battery aging cost** per cycle.

Intuitively, the objective is:

- Charge when prices are low;
- Discharge when prices are high;
- While avoiding excessive degradation of the battery.

### Constraints

The operation of each DBESS is subject to:

1. **Power limits**

   The charging/discharging power cannot exceed the rated power:

   $$|P_t| \le P^{\mathrm{rated}}.$$

2. **Energy / SOC limits**

   The battery energy / SOC must remain within safe bounds, and there must be enough energy to discharge and enough headroom to charge:

   $$0 \le S_t \le Q^{\mathrm{rated}},$$

   and the SOC evolves according to the state transition:

   $$S_{t+1} = S_t + P_t \cdot \Delta t.$$

3. **Aging cost**

   Battery aging is modeled through a cycle-counting-based degradation cost.  
   Each charge/discharge cycle contributes to a **lifetime consumption** measure, which is converted into a monetary **aging cost per period** based on:

   - Purchase cost;
   - Maximum allowable cycle count;
   - Remaining useful life.

### Reinforcement Learning Formulation

The arbitrage problem is cast as a **finite-horizon Markov Decision Process (MDP)**:

- **State** $s_t$

  - Battery SOC (or discretized energy state);
  - Time index (e.g., hour of day).

- **Action** $a_t$

  - Discrete charging/discharging power levels:

    $$a_t \in \{-Q^{\mathrm{max}}, \dots, -\Delta P, 0, \Delta P, \dots, Q^{\mathrm{max}}\}.$$

- **Reward** $r_t$
  - Period profit at time $t$: electricity price $\times$ power $\times$ time step, **minus** loss cost and aging cost.

The repository implements a **tabular Q-learning** scheme:

- **Q-learning update**
  - Standard temporal-difference update with learning rate and reward discount factor.
- **Exploration policy**
  - $\varepsilon$-greedy: with probability $\varepsilon$ take a random action; otherwise follow the action with the highest Q-value.
- **Target policy**
  - Greedy (exploitation) policy used for evaluation.

After sufficient training episodes, the resulting policy naturally learns **low-price charging** and **high-price discharging**, while respecting operational and degradation constraints.

---

## Repository Structure

A typical layout of this repository is:

```text
DBESS-Arbitrage/
├── README.md                      # Project description
├── DBESS模型建立与求解.pdf        # Mathematical model & case study description (Chinese)
├── src/
│   ├── calcuC.m                   # Computes DBESS aging & operating cost
│   ├── updateS.m                  # SOC state transition equation
│   ├── case1.mlx                  # Case 1: Single DBESS, basic arbitrage behavior
│   ├── case2.mlx                  # Case 2: Different aging levels
│   ├── case3.mlx                  # Case 3: Different initial SOC
│   ├── case4.mlx                  # Case 4: RL vs. Simulated Annealing
│   ├── case5.mlx                  # Case 5: Generalization to perturbed price series
│   ├── draw1.mlx                  # Visualization for Case 1
│   ├── draw2.mlx                  # Visualization for Case 2
│   ├── draw3.mlx                  # Visualization for Case 3
│   ├── draw4.mlx                  # Visualization for Case 4
│   └── draw5.mlx                  # Visualization for Case 5
├── data/
│   └── *.mat / *.csv              # Data generated by case scripts for visualization
└── pictures/
    └── *.png / *.jpg              # Saved figures showing DBESS strategies and profits
```
