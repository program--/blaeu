import { createMap } from './map'

//@ts-ignore
HTMLWidgets.widget({
    name: 'map',
    type: 'output',
    factory: createMap
})