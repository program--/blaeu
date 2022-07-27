export function handleSfObjects(data, geometryColumn): Object {
    if (geometryColumn == undefined) {
        geometryColumn = data['geom'] != undefined
            ? 'geom'
            : data['Shape'] != undefined
                ? 'Shape'
                : 'geometry'
    }

    const features = data[geometryColumn].map((val, idx) => {
        const propNames = Object.keys(data)
        propNames.pop()
        const properties = {}
        for (const name of propNames) {
            properties[name] = data[name][idx]
        }
        return {
            type: 'Feature',
            properties: properties,
            geometry: val
        }
    })

    return {
        type: 'FeatureCollection',
        features: features
    }
}