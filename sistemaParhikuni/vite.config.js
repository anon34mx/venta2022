import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

// server: { https: false, cors: false, hmr: false, port: 5174 },
// server: {
//     host: '172.17.1.138',
//     port: 8000,
//     cors: false,
// },
export default defineConfig({
    server:{
        host: "172.17.1.138"
    },
    plugins: [
        laravel({
            input: [
                'resources/sass/app.scss',
                'resources/js/app.js',
            ],
            refresh: true,
        }),
    ],
});
