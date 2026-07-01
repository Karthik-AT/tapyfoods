document.addEventListener('DOMContentLoaded', () => {

    const catTabs    = document.querySelectorAll('.cat-tab');
    const menuItems  = document.querySelectorAll('.menu-item-card');
    const catSections = document.querySelectorAll('.menu-category-section');

    catTabs.forEach(tab => {
        tab.addEventListener('click', () => {
            catTabs.forEach(t => t.classList.remove('active'));
            tab.classList.add('active');

            const selected = tab.dataset.category;

            if (selected === 'all') {
                catSections.forEach(s => s.style.display = '');
                menuItems.forEach(item => item.classList.remove('hidden'));
            } else {
                catSections.forEach(section => {
                    section.style.display =
                        section.dataset.category === selected ? '' : 'none';
                });
                menuItems.forEach(item => {
                    if (item.dataset.category === selected) {
                        item.classList.remove('hidden');
                    } else {
                        item.classList.add('hidden');
                    }
                });
            }
        });
    });

    document.querySelectorAll('.qty-form').forEach(form => {
        const display  = form.querySelector('.qty-display');
        const qtyInput = form.querySelector('.qty-hidden-input');
        const decBtn   = form.querySelector('.qty-btn.dec');
        const incBtn   = form.querySelector('.qty-btn.inc');

        if (!display || !decBtn || !incBtn) return;

        let qty = parseInt(display.textContent) || 1;

        decBtn.addEventListener('click', () => {
            if (qty > 1) {
                qty--;
                display.textContent = qty;
                if (qtyInput) qtyInput.value = qty;
            }
        });

        incBtn.addEventListener('click', () => {
            if (qty < 10) {
                qty++;
                display.textContent = qty;
                if (qtyInput) qtyInput.value = qty;
            }
        });
    });

    const toast = document.createElement('div');
    toast.id = 'cart-toast';
    toast.style.cssText = `
        position: fixed;
        bottom: 32px;
        left: 50%;
        transform: translateX(-50%) translateY(80px);
        background: #2B1810;
        color: #F7EEDC;
        padding: 12px 24px;
        border-radius: 999px;
        font-family: 'Inter', sans-serif;
        font-size: 0.9rem;
        font-weight: 600;
        z-index: 9999;
        transition: transform 0.3s cubic-bezier(0.22,1,0.36,1), opacity 0.3s ease;
        opacity: 0;
        pointer-events: none;
        white-space: nowrap;
        box-shadow: 0 8px 32px rgba(43,24,16,0.25);
    `;
    document.body.appendChild(toast);

    let toastTimeout;

    function showToast(message) {
        clearTimeout(toastTimeout);
        toast.textContent = message;
        toast.style.transform = 'translateX(-50%) translateY(0)';
        toast.style.opacity   = '1';
        toastTimeout = setTimeout(() => {
            toast.style.transform = 'translateX(-50%) translateY(80px)';
            toast.style.opacity   = '0';
        }, 2500);
    }

    document.querySelectorAll('.add-to-cart-form').forEach(form => {
        form.addEventListener('submit', (e) => {
            const itemName = form.closest('.menu-item-card')
                                 ?.querySelector('.menu-item-name')
                                 ?.textContent || 'Item';
            showToast(`🛒 ${itemName} added to cart!`);
        });
    });

    const tabsContainer = document.querySelector('.menu-category-tabs-wrap');
    if (tabsContainer) {
        const tabsTop = tabsContainer.getBoundingClientRect().top + window.scrollY;
        window.addEventListener('scroll', () => {
            if (window.scrollY > tabsTop - 73) {
                tabsContainer.classList.add('tabs-sticky');
            } else {
                tabsContainer.classList.remove('tabs-sticky');
            }
        });
    }

});
