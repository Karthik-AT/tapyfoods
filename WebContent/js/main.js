document.addEventListener('DOMContentLoaded', () => {

    const searchInput   = document.getElementById('restaurant-search');
    const filterTabs    = document.querySelectorAll('.filter-tab');
    const restaurantCards = document.querySelectorAll('.rest-card-wrap');
    const noResults     = document.getElementById('no-results-msg');

    let activeFilter = 'all';

    function filterRestaurants() {
        const query = searchInput ? searchInput.value.trim().toLowerCase() : '';

        let visibleCount = 0;

        restaurantCards.forEach(wrap => {
            const name    = (wrap.dataset.name    || '').toLowerCase();
            const cuisine = (wrap.dataset.cuisine || '').toLowerCase();

            const matchesSearch = !query || name.includes(query) || cuisine.includes(query);
            const matchesFilter = activeFilter === 'all' || cuisine.includes(activeFilter.toLowerCase());

            if (matchesSearch && matchesFilter) {
                wrap.style.display = '';
                visibleCount++;
            } else {
                wrap.style.display = 'none';
            }
        });

        if (noResults) {
            noResults.style.display = visibleCount === 0 ? 'block' : 'none';
        }
    }

    if (searchInput) {
        searchInput.addEventListener('input', filterRestaurants);
    }

    filterTabs.forEach(tab => {
        tab.addEventListener('click', () => {
            filterTabs.forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
            activeFilter = tab.dataset.filter;
            filterRestaurants();
        });
    });

    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            const target = document.querySelector(targetId);
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });

    const alerts = document.querySelectorAll('.error-alert, .success-alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.4s ease';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 400);
        }, 5000);
    });

});
