---
name: cognitive-biases
description:
  Apply cognitive bias knowledge to product design and decision-making. Use when
  designing user experiences, analyzing user behavior, improving conversions, or
  ensuring ethical design practices.
---

# Cognitive Biases - Psychology for Product Design

Understanding psychological patterns that influence human decision-making,
first systematically studied by Kahneman and Tversky.
Essential for creating user experiences that work with human psychology.

## When to Use This Skill

- Designing user onboarding flows
- Improving conversion rates ethically
- Analyzing why users behave unexpectedly
- Reviewing designs for dark patterns
- Planning pricing and positioning strategies
- Understanding decision-making in user research

## Foundation: Dual-Process Theory

```text
┌─────────────────────────────────────────────────────────────────┐
│                     HUMAN DECISION-MAKING                        │
├────────────────────────────┬────────────────────────────────────┤
│       SYSTEM 1 (95%)       │          SYSTEM 2 (5%)             │
├────────────────────────────┼────────────────────────────────────┤
│ Fast                       │ Slow                               │
│ Automatic                  │ Deliberate                         │
│ Intuitive                  │ Analytical                         │
│ Unconscious                │ Conscious                          │
│ Associative                │ Logical                            │
│ Low effort                 │ High effort                        │
│ Emotional                  │ Rational                           │
├────────────────────────────┼────────────────────────────────────┤
│ "Feels right"              │ "Let me think about this"          │
└────────────────────────────┴────────────────────────────────────┘

Most user interactions happen through System 1.
Design for intuition, not just logic.
```

## Core Cognitive Biases

### 1. Anchoring Bias

**What it is:** The brain latches onto the first piece of information as a reference point
for all subsequent decisions.

```text
Pricing Example:

❌ Without anchor:
   "Pro plan: $49/month"
   User thinks: "Is that expensive?"

✅ With anchor:
   "Enterprise: $199/month" (shown first)
   "Pro plan: $49/month"
   User thinks: "That's a great deal!"
```

**Product applications:**

- Show premium/enterprise tier first in pricing tables
- Display original price crossed out before sale price
- Set high initial expectations, then exceed them

### 2. Loss Aversion

**What it is:** Humans feel losses 2x more intensely than equivalent gains.

```text
Framing comparison:

Gain frame (weaker):    "Save $100 with annual billing"
Loss frame (stronger):  "You're losing $100 by paying monthly"

Progress frame:
Weaker:  "Complete setup to unlock features"
Stronger: "Don't lose your progress - 80% complete"
```

**Product applications:**

- Free trials that create ownership feeling
- Progress indicators showing what users might lose
- "Save" vs "Spend" framing in messaging

### 3. Availability Bias

**What it is:** We overestimate the likelihood of events we can easily recall.

```text
Making success feel common:

"Join 50,000+ developers"        → Success is common
"Featured in TechCrunch"         → Credibility by association
"Sarah from NYC just signed up"  → Real-time social proof
"5 people viewing this now"      → Popularity signal
```

**Product applications:**

- Social proof and testimonials prominently displayed
- Recent activity feeds that influence behavior
- Success stories that make outcomes feel achievable

### 4. Confirmation Bias

**What it is:** We seek information confirming existing beliefs and ignore contradictory evidence.

```text
Personalization flow:

User selects: "I'm a developer"
    ↓
Show: Developer-focused features
Hide: Marketing automation features
    ↓
User thinks: "This product gets me"
```

**Product applications:**

- Personalized onboarding based on user type
- Customizable dashboards reflecting preferences
- Content recommendations aligned with interests

### 5. Planning Fallacy

**What it is:** We consistently underestimate how long tasks will take.

```text
Setting realistic expectations:

❌ "Quick setup"           → User expects 1 min, takes 10
✅ "10-minute setup"       → User expects 10, finishes in 8

Progress that manages expectations:
┌────────────────────────────────────┐
│ Step 2 of 5 · About 4 minutes left │
│ ████████░░░░░░░░░░░░░░ 40%         │
└────────────────────────────────────┘
```

**Product applications:**

- Realistic time estimates for user tasks
- Progress indicators with time remaining
- Break complex tasks into visible steps

### 6. Framing Effect

**What it is:** How information is presented changes decisions,
even when underlying data is identical.

```text
Same data, different perception:

Negative frame: "10% of projects fail"
Positive frame: "90% success rate"

Feature absence: "No hidden fees"
Feature presence: "Transparent pricing"

Risk frame: "You might lose data"
Safety frame: "Your data is protected"
```

**Product applications:**

- Positive framing in UI copy and messaging
- Feature benefits vs feature absence language
- Success-oriented progress messaging

### 7. Sunk Cost Fallacy

**What it is:** We continue investing because of past investments, not future value.

```text
Leveraging investment:

"You've been with us for 2 years"
"Don't lose your 500 saved items"
"Your profile is 80% complete"
"3,000 connections would miss you"
```

**Product applications:**

- Progress saving and restoration features
- Investment tracking showing accumulated value
- Gentle reminders of past engagement

### 8. Social Proof

**What it is:** We look to others' behavior to determine correct actions.

```text
Types of social proof:

Expert:     "Recommended by security researchers"
Celebrity:  "Used by Elon Musk"
User:       "500,000+ teams trust us"
Wisdom:     "Most popular plan"
Peers:      "Teams like yours use Premium"
```

**Product applications:**

- Customer logos and testimonials
- Usage statistics and popularity indicators
- "Most popular" badges on pricing plans

### 9. Scarcity

**What it is:** We value things more when they're rare or diminishing.

```text
Scarcity signals:

Time:      "Sale ends in 2:34:12"
Quantity:  "Only 3 seats left"
Access:    "Invite-only beta"
Exclusivity: "Limited to 100 companies"

⚠️  Only use with REAL scarcity
```

**Product applications:**

- Limited-time offers (when genuinely limited)
- Stock/availability indicators
- Waitlist and invite-only access

## Bias Analysis Framework

### Step 1: Identify Decision Points

Map where users make decisions:

```text
User Journey Decision Points:

Landing Page
├── Stay or bounce?           [Availability, Social Proof]
├── Which CTA to click?       [Framing, Anchoring]
│
Signup
├── Email or social login?    [Convenience, Trust]
├── Share optional data?      [Reciprocity]
│
Pricing
├── Which plan?               [Anchoring, Decoy]
├── Monthly or annual?        [Loss Aversion]
│
Onboarding
├── Complete or skip?         [Commitment, Sunk Cost]
├── Invite teammates?         [Social Proof]
│
Retention
├── Continue or churn?        [Sunk Cost, Loss Aversion]
└── Upgrade or stay?          [Anchoring, Social Proof]
```

### Step 2: Map Current Bias Usage

Audit existing design:

| Screen    | Decision       | Bias Used     | Ethical? | Effective? |
| --------- | -------------- | ------------- | -------- | ---------- |
| Pricing   | Plan selection | Anchoring     | ✅       | ✅         |
| Checkout  | Add extras     | Scarcity      | ⚠️ Fake  | ❌         |
| Trial end | Convert        | Loss aversion | ✅       | ✅         |

### Step 3: Design Improvements

For each decision point:

```text
Decision: Plan selection

Current state:
- Plans listed low to high
- No default highlighted
- Equal visual weight

Improved design:
- Anchor with Enterprise first (Anchoring)
- "Most popular" badge on target plan (Social Proof)
- "Recommended for you" personalization (Confirmation)
- Annual savings calculated (Loss Aversion)
```

## Output Template

After completing analysis, document as:

```markdown
## Cognitive Bias Analysis

**Product/Feature:** [Name]

**Analysis Date:** [Date]

### Decision Point Audit

| Decision Point | Current Biases | Ethical Assessment | Recommendations |
| -------------- | -------------- | ------------------ | --------------- |
| [Point 1]      | [Biases used]  | [✅/⚠️/❌]         | [Changes]       |
| [Point 2]      | [Biases used]  | [✅/⚠️/❌]         | [Changes]       |

### Recommended Improvements

#### High Priority

- [Improvement 1]: Apply [bias] at [location] to [effect]
- [Improvement 2]: Remove [dark pattern] from [location]

#### Medium Priority

- [Improvement 3]
- [Improvement 4]

### Ethical Checklist

- [ ] All scarcity claims are factual
- [ ] Users can easily reverse decisions
- [ ] No exploitation of vulnerable states
- [ ] Transparent about pricing and terms
- [ ] Personalization is controllable

### Success Metrics

| Metric            | Current | Target | Measurement   |
| ----------------- | ------- | ------ | ------------- |
| Conversion rate   | X%      | Y%     | Analytics     |
| User satisfaction | X       | Y      | Survey        |
| Regret rate       | X%      | <Y%    | Cancellations |
```

## Ethical Guidelines

### ✅ Do: Enhance Experience

```text
Ethical bias application:

Reducing cognitive load:
├── Smart defaults (don't make users think)
├── Progressive disclosure (show what's relevant)
└── Clear visual hierarchy (guide attention)

Building trust:
├── Real testimonials with names/photos
├── Honest scarcity (actual inventory)
└── Transparent pricing (no surprises)

Helping decisions:
├── Comparison tables (reduce effort)
├── Recommendations (based on real fit)
└── Clear CTAs (obvious next steps)
```

### ❌ Don't: Exploit Users

```text
Dark patterns to avoid:

Fake urgency:
├── "Only 2 left!" (when unlimited)
├── "Sale ends soon!" (perpetual sale)
└── Countdown timers that reset

Hidden information:
├── Fees revealed at checkout
├── Auto-renewal buried in terms
└── Difficult cancellation flows

Manipulation:
├── Guilt-tripping copy
├── Confirm-shaming ("No, I don't want to save money")
└── Trick questions in opt-outs
```

### Ethical Decision Framework

```text
Before applying a bias, ask:

1. Is this helping the user?
   YES → Continue
   NO  → Stop

2. Would I be comfortable if this was exposed?
   YES → Continue
   NO  → Stop

3. Does this create long-term value?
   YES → Continue
   NO  → Stop

4. Would this work on an informed user?
   YES → Continue (persuasion)
   NO  → Stop (manipulation)
```

## Real-World Examples

### Amazon: Ethical Anchoring

```text
Product page:

List Price:    $79.99  ──→ Anchor (if real MSRP)
Price:         $49.99
You Save:      $30.00 (38%)

✅ Ethical if list price is genuine
❌ Unethical if inflated for appearance
```

### Spotify: Positive Framing

```text
Subscription conversion:

"Get 3 months free"
    vs
"Pay for 9 months, get 12"

Same value, different perception.
Ethical because both options are clearly available.
```

### Duolingo: Commitment + Loss Aversion

```text
Streak system:

"🔥 15 day streak!"
"Don't break your streak - practice now"

✅ Ethical: Creates positive habit
⚠️ Watch for: Anxiety-inducing pressure
```

## Integration with Other Methods

| Method              | Combined Use                            |
| ------------------- | --------------------------------------- |
| **Five Whys**       | Why do users behave unexpectedly?       |
| **Graph Thinking**  | Map bias influences across user journey |
| **Business Canvas** | Bias impact on value proposition        |
| **Jobs-to-be-Done** | Align bias use with user goals          |
| **A/B Testing**     | Validate bias effectiveness ethically   |

## Quick Reference

```text
BIAS CHEAT SHEET

Acquisition:
├── Social Proof → "Join 50,000+ users"
├── Anchoring → Show premium first
└── Scarcity → "Limited beta access"

Activation:
├── Commitment → Small first steps
├── Planning Fallacy → Realistic time estimates
└── Loss Aversion → Show progress at risk

Retention:
├── Sunk Cost → "Your history, connections"
├── Confirmation → Personalized experience
└── Social Proof → "Your team uses this"

Revenue:
├── Anchoring → Price comparison
├── Framing → Annual savings highlighted
└── Loss Aversion → "You're losing $X/month"

Referral:
├── Social Proof → "X friends joined"
├── Reciprocity → Give before asking
└── Scarcity → "Exclusive invite codes"
```

## Resources

- [Thinking, Fast and Slow - Daniel Kahneman](https://www.goodreads.com/book/show/11468377-thinking-fast-and-slow)
- [Predictably Irrational - Dan Ariely](https://danariely.com/books/predictably-irrational/)
- [Hooked - Nir Eyal](https://www.nirandfar.com/hooked/)
- [Dark Patterns Hall of Shame](https://darkpatterns.org/)
- [Growth.Design Psychology Studies](https://growth.design/psychology)
