import path from 'path'
import { defineConfig } from 'vite'

module.exports = defineConfig({
    build: {
        lib: {
            entry: path.resolve(__dirname, 'lib/main.ts'),
            name: 'blaeu',
            fileName: (format) => 'map.js'
        },
        target: 'esnext',
        outDir: '../inst/htmlwidgets',
        emptyOutDir: false
    }
})