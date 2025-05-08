self.addEventListener('install', event => {
    console.log('Service Worker installing.');
    event.waitUntil(
      caches.open('counter-cache-v1').then(cache => {
        return cache.addAll(['index.html', 'app.js']);
      })
    );
  });
  
  self.addEventListener('fetch', event => {
    event.respondWith(
      caches.match(event.request).then(response => {
        return response || fetch(event.request);
      })
    );
  });
  