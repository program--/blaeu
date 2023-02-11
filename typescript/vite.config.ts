import path from 'path'
import { defineConfig } from 'vite'

export default defineConfig({
    build: {
        lib: {
            entry: path.resolve(__dirname, 'lib/main.ts'),
            name: 'blaeu',
            formats: ['umd'],
            fileName: (_) => 'blaeu.js'
        },
        target: 'modules',
        minify: 'esbuild',
        outDir: '../inst/htmlwidgets',
        emptyOutDir: false
    }
})