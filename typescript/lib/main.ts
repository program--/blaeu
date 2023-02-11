import maplibregl from 'maplibre-gl'
import methods, { RArgs } from './methods'
import { Protocol } from 'pmtiles'

const protocol = new Protocol();
maplibregl.addProtocol("pmtiles", protocol.tile)

interface WidgetData {
    props: { style: string | maplibregl.StyleSpecification } | any,
    calls: Array<{methodName: string, args: RArgs}>
}

//@ts-ignore
HTMLWidgets.widget({
    name: 'map',
    type: 'output',
    factory: function (el: HTMLElement, width: string, height: string) {
        // Create new map using `el`
        const map = new maplibregl.Map({
            container: el.id,
            style: null
        })
    
        return {
            renderValue: function (widgetData: WidgetData) {
                map.setStyle(widgetData.props.style);
                map.on('load', () => widgetData.calls.forEach(({ methodName, args }) => {
                    methods[methodName].call(map, args);
                }));
            },
            m: map
        }
    }
})