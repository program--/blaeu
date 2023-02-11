import { LayerSpecification, Popup, SourceSpecification } from 'maplibre-gl';
import { handleSfObjects } from './sf'

export type RArgs = SourceArgs | LayerArgs

interface SourceArgs {
    id?: any,
    data?: any,
    type?: string,
    sf?: boolean,
    sf_col?: string,
    tiles?: string | Array<any>
}

interface LayerArgs {
    id?: any,
    source?: any,
    'source-layer'?: string,
    type: string,
    paint?: any,
    popup?: PopupArgs
}

interface PopupArgs {
    id?: string,
    text?: string
}

async function addSource(aargs: Array<SourceArgs>) {
    const map: maplibregl.Map = this;
    const args = aargs[0];
    const id = args.id
    delete args.id

    // Handle sf objects
    if (args.sf != undefined && args.sf) {
        delete args.sf
        args.data = handleSfObjects(args.data, args.sf_col)
        if (args.sf_col != undefined) delete args.sf_col
    }

    // Handle vector tiles
    if (args.tiles != undefined) {
        args.tiles = args.tiles instanceof Array
            ? args.tiles
            : [args.tiles]
    }

    map.addSource(id, args as SourceSpecification)
}

function addLayer(args: LayerArgs) {
    const map: maplibregl.Map = this;
    let popup = undefined
    if (args['popup'] != undefined) {
        popup = args['popup']
        delete args['popup']
    }

    map.once('sourcedata', () => {
        map.addLayer(args as LayerSpecification)

        if (popup != undefined) {
            addPopup.call(map, popup)
        }
    })

}

function addPopup(args: PopupArgs) {
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