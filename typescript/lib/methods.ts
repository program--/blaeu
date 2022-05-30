function addSource(args) {
    const map: maplibregl.Map = this;
    args = args[0];
    map.addSource(args['id'], {
        type: args['type'],
        data: args['data']
    })
}

function addLayer(args) {
    this.addLayer(args)
}

export default {
    addSource,
    addLayer
}