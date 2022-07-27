import geojsonvt from "geojson-vt";
import vtpbf from 'vt-pbf'
import { PNGDecompress } from "./png";

const tilesets = {}

export async function embeddedVTProtocol(params, callback) {
    const re = new RegExp(/tiles:\/\/(.+)\/(\d+)\/(\d+)\/(\d+)/);
    const result = params.url.match(re);
    const id = result[1]

    if (tilesets[id] == undefined) {
        tilesets[id] = geojsonvt(await PNGDecompress(`_local--${id}`), {})
    }

    const tiles = tilesets[id]

    if (tiles == undefined) {
        callback(new Error(`Source error: ID ${id} not found.`));
    }

    const z = result[2];
    const x = result[3];
    const y = result[4];
    let cancel = () => { };
    const tile = tiles.getTile(+z, +x, +y)

    const buf: Uint8Array = vtpbf.fromGeojsonVt({ 'default': tile }, { version: 2 })
    if (buf) {
        try {
            callback(null, buf, null, null)
        } catch (error) {
            callback(new Error("Canceled"), null, null, null)
        }
    } else {
        callback(null, new Uint8Array(), null, null)
    }

    return {
        cancel: () => {
            cancel();
        }
    }
}