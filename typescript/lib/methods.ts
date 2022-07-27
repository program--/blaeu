import { Popup } from 'maplibre-gl';
import { PNGCompress } from './png';
import { handleSfObjects } from './sf'

async function addSource(args) {
    const map: maplibregl.Map = this;
    args = args[0];
    const id = args['id']
    delete args['id']

    // Handle sf objects
    if (args['sf'] != undefined && args['sf']) {
        delete args['sf']
        args['data'] = handleSfObjects(args['data'], args['sf_col'])
        if (args['sf_col'] != undefined) delete args['sf_col']
    }

    // Handle embedded vector tiles
    if (args['tiled'] != undefined && args['tiled']) {
        delete args['tiled']

        const element = await PNGCompress(args['data'], id)
        document.body.append(element)
        delete args['data']

        args['tiles'] = `tiles://${id}/{z}/{x}/{y}`
        args['type'] = 'vector'
    }

    // Handle vector tiles
    if (args['tiles'] != undefined) {
        args['tiles'] = args['tiles'] instanceof Array
            ? args['tiles']
            : [args['tiles']]
    }

    map.addSource(id, args)
}

function addLayer(args: Object) {
    let popup = undefined
    if (args['popup'] != undefined) {
        popup = args['popup']
        delete args['popup']
    }

    this.once('sourcedata', () => {
        this.addLayer(args)

        if (popup != undefined) {
            addPopup.call(this, popup)
        }
    })

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