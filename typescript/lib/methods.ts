import { Popup } from 'maplibre-gl'

function addSource(args) {
    const map: maplibregl.Map = this;
    args = args[0];
    map.addSource(args['id'], {
        type: args['type'],
        data: args['data']
    })
}

function addLayer(args) {
    let popup = undefined
    if (args['popup'] != undefined) {
        popup = args['popup']
        delete args['popup']
    }

    this.addLayer(args)

    if (popup != undefined) {
        addPopup.call(this, popup)
    }
    
}

function addPopup(args) {
    const map: maplibregl.Map = this;
    map.on('click', args['id'], (e) => {
        const feature = e.features[0];
        const text: string = args['text'].replace(
            /\${(.*?)}/g, (x, g) => feature.properties[g]
        )

        const popup = new Popup()
            .setLngLat(feature.geometry.type === "Point"
                       ? feature.geometry.coordinates as [number, number]
                       : e.lngLat)
            .setHTML(text)
            .addTo(map)
    })
}

export default {
    addSource,
    addLayer
}