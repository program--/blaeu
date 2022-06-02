import maplibregl from 'maplibre-gl'
import methods from './methods'
import { ProtocolCache } from 'pmtiles'

maplibregl.addProtocol("pmtiles", new ProtocolCache().protocol)

export function createMap(el: HTMLElement, width: string, height: string) {
    const map = new maplibregl.Map({
        container: el.id,
        style: null
    })

    const renderValue = function (widgetData) {
        map.setStyle(widgetData.props.style);
        map.on('load', () => widgetData.calls.forEach(({ methodName, args}) => {
            methods[methodName].call(map, args);
        }))
    }


    return { renderValue: renderValue, m: map }
}