import { createMap } from './map'
HTMLWidgets.widget({
    name: 'map',
    type: 'output',
    factory: createMap
})