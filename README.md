# 🍽️ Tapy Food — *Taste the Difference, Delivered.*

> A **production-ready food delivery web application** built with pure HTML & CSS, powered by the **Coffee Roast** design system.

---

## 📌 Table of Contents

- [🚀 About the Project](#-about-the-project)
- [🎨 Design Theme — Coffee Roast](#-design-theme--coffee-roast)
- [🖌️ Color Palette](#️-color-palette)
- [🔤 Typography System](#-typography-system)
- [📐 Design Language](#-design-language)
- [🗂️ Project Structure](#️-project-structure)
- [📄 Page Sections](#-page-sections)
- [🖼️ Images](#️-images)
- [📱 Responsive Design](#-responsive-design)
- [⚙️ How to Run](#️-how-to-run)
- [✅ Design Principles](#-design-principles)

---

## 🚀 About the Project

**Tapy Food** is a premium, fully responsive food delivery landing page that simulates a real-world production website. It is designed to demonstrate:

- ✅ Clean, semantic **HTML5** structure
- ✅ Advanced **CSS** layout techniques (Grid + Flexbox)
- ✅ A consistent **design system** applied throughout
- ✅ Real **high-quality images** from Unsplash
- ✅ **Accessibility** best practices (ARIA labels, semantic tags)
- ✅ **Mobile-first** responsive design

| Property | Detail |
|---|---|
| 🏷️ App Name | **Tapy Food** |
| 📁 Folder | `Day10 / CSS selectors` |
| 🛠️ Built With | HTML5, Vanilla CSS |
| 🎨 Design System | Coffee Roast |
| 🔤 Fonts | Fraunces + Inter (Google Fonts) |
| 📱 Responsive | Yes — Mobile, Tablet, Desktop |

---

## 🎨 Design Theme — Coffee Roast

The entire visual identity is based on the **Coffee Roast** design system — a third-wave specialty coffee aesthetic that uses:

> *Espresso brown · Kraft paper neutrals · Latte warm surfaces · A single burnt-orange accent*

This system is **intentionally flat** — no gradients, no neon, no clutter. Every design decision is purposeful and rooted in warmth, legibility, and premium restraint.

---

## 🖌️ Color Palette

| Role | Name | Hex | Usage |
|---|---|---|---|
| 🟫 **Primary** | Espresso Brown | `#2B1810` | Headlines, core text, footer |
| 🪵 **Secondary** | Warm Taupe | `#8A7260` | Captions, subtext, borders |
| 🟠 **Tertiary** | Burnt Orange | `#D97742` | CTA buttons, accent only |
| 🟨 **Neutral** | Kraft Paper | `#EBE0CE` | Page background, card fills |
| 🤍 **Surface** | Latte White | `#F7EEDC` | Cards, panels, hero badges |
| 🟤 **On-Primary** | Cream | `#F7EEDC` | Text on dark backgrounds |

> ⚠️ **Single-accent rule:** Burnt Orange (`#D97742`) is used for **exactly one interactive action per screen**. This is a core design constraint — never mix it with alternate accents.

---

## 🔤 Typography System

Two carefully chosen Google Fonts form the entire typographic system:

### 🖋️ Fraunces — Display & Headings
```
Font Family : Fraunces (Optical Sizing, Serif)
Usage       : Hero headings, section titles, card names, prices
Weight      : 600 (Semi-bold)
Style       : Italic used for brand emphasis
Letter Spacing: -0.02em (tight for elegance)
```

### 📝 Inter — Body & Labels
```
Font Family : Inter (Sans-serif, Variable)
Usage       : Body paragraphs, nav links, labels, form fields
Weight      : 400 (Regular), 500 (Medium), 600 (Semi-bold)
Line Height : 1.6 for comfortable reading
```

| Style | Font | Size | Weight |
|---|---|---|---|
| 🅰️ Display | Fraunces | `clamp(3rem → 4.5rem)` | 600 |
| H1 | Fraunces | `clamp(2rem → 2.4rem)` | 600 |
| H2 | Fraunces | `clamp(1.5rem → 2rem)` | 600 |
| Body | Inter | `0.98rem` | 400 |
| Label | Inter | `0.72rem` | 600 + UPPERCASE |

---

## 📐 Design Language

### 📦 Spacing System
```
--sp-xs  :  4px
--sp-sm  :  8px
--sp-md  : 16px
--sp-lg  : 32px
--sp-xl  : 56px
--sp-2xl : 96px
```

### 🔲 Border Radius
```
--r-sm   :  4px   → Small tags
--r-md   :  8px   → Buttons, inputs
--r-lg   : 14px   → Cards
--r-xl   : 20px   → Hero image, about image
--r-pill : 999px  → Badges, eyebrows
```

### ✨ Interaction Principles
- **Hover lift** — Cards rise `translateY(-8px)` on hover
- **Image zoom** — Images scale `1.05x` inside their container on hover
- **Button press** — Buttons sink `translateY(1px)` on active/click
- **Smooth transitions** — All transitions use custom easing `cubic-bezier(0.22, 1, 0.36, 1)`
- **No gradients** — The Coffee Roast system is flat by design

---

## 🗂️ Project Structure

```
📁 Day10/
└── 📁 CSS selectors/
    ├── 📄 index.html     ← All page structure & content
    ├── 🎨 style.css      ← Complete design system & layout
    └── 📋 README.md      ← You are here!
```

---

## 📄 Page Sections

The page is divided into **8 fully designed sections**:

| # | Section | Description |
|---|---|---|
| 1 | 🦸 **Hero** | Full-viewport split layout with food photography, headline, stats bar & CTA |
| 2 | 🔢 **How It Works** | 3-step process cards on a warm surface panel |
| 3 | 📖 **Our Story** | About section with split layout, kitchen image, and achievement badge |
| 4 | 🏪 **Best Restaurants** | 3 restaurant cards with ratings, labels, and order buttons |
| 5 | 🍕 **Best Sellers** | 4 food item cards with Hot / Vegan / Chef's Pick badges and prices |
| 6 | 💬 **Testimonials** | 3 customer review cards with avatars and italic Fraunces quotes |
| 7 | 📬 **Contact** | Split panel — contact info + full form with catering request |
| 8 | 🦶 **Footer** | Rich dark footer with navigation links, social icons, and legal links |

---

## 🖼️ Images

All images are **real, high-quality photographs** sourced from **[Unsplash](https://unsplash.com)** — no placeholders.

| Image | Source | Used In |
|---|---|---|
| 🍽️ Gourmet Food Spread | Unsplash | Hero Section |
| 🍕 Pepperoni Pizza | Unsplash | Best Sellers |
| 🍔 Bacon Cheeseburger | Unsplash | Best Sellers |
| 🥩 Ribeye Steak | Unsplash | Best Sellers |
| 🥗 Quinoa Salad | Unsplash | Best Sellers |
| 🏛️ Grand Bistro Interior | Unsplash | Best Restaurants |
| 🍣 Sushi Platter | Unsplash | Best Restaurants |
| 🍷 Italian Restaurant | Unsplash | Best Restaurants |
| 👨‍🍳 Chef in Kitchen | Unsplash | About Section |
| 👤 Customer Avatars (×3) | Unsplash | Testimonials |

> 💡 Images are optimised with `?w=700&q=85&auto=format&fit=crop` query parameters for fast loading.

---

## 📱 Responsive Design

The layout adapts across three breakpoints:

```
🖥️  Desktop  →  > 900px   : Two-column hero, 3-col cards, side-by-side about
📱  Tablet   →  ≤ 900px   : Single column hero, stacked about, 1-col contact
📲  Mobile   →  ≤ 640px   : Full-width everything, collapsed nav, stacked buttons
```

---

## ⚙️ How to Run

### Option 1 — Python Local Server *(Recommended)*
```bash
# Navigate to the folder
cd "Day10/CSS selectors"

# Start a server on port 5500
python -m http.server 5500

# Open in browser
http://localhost:5500
```

### Option 2 — VS Code Live Server
1. Install the **Live Server** extension in VS Code
2. Right-click `index.html`
3. Select **"Open with Live Server"**
4. Auto-refreshes on every save ✨

### Option 3 — Direct File
Open `index.html` directly in any modern browser.

---

## ✅ Design Principles

These rules are **non-negotiable** in the Coffee Roast system:

| ✅ Do | ❌ Don't |
|---|---|
| Use Tertiary for **one CTA per screen** | Mix Tertiary with alternate accent colors |
| Let Neutral carry the composition | Fill every space — negative space is a feature |
| Use Fraunces for all headings | Use Fraunces for body text |
| Use Inter for labels & body | Use decorative fonts for UI text |
| Keep the design **flat** | Add gradients or glows |
| Use `rem`/`clamp` for type sizes | Use fixed `px` for font sizes |

---

<div align="center">

Made with ❤️ · **Tapy Food** · © 2026 All Rights Reserved

*"Taste the Difference, Delivered."*

</div>
