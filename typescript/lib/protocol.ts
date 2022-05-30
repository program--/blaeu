import vtpbf from 'vt-pbf'

function localVtProtocol(params, callback) {
    const re = new RegExp(/vectortiles:\/\/(.+)\/(\d+)\/(\d+)\/(\d+)/);
    const result = params.url.match(re);
    const tiles: any = window[result[1]];

    if (tiles == undefined) {
        callback(new Error(`Source error: var ${result[1]} not found.`));
    }

    const z = result[2];
    const x = result[3];
    const y = result[4];
    const buf = vtpbf.fromGeojsonVt({'local': tiles.getTile(z, x, y)})
    callback(null, buf, null, null)
}