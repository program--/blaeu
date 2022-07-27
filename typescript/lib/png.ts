import { ImageData as PNG, encode as PNGEncode, decode as PNGDecode } from 'fast-png'
import { encode as msgpackEncode, decode as msgpackDecode } from '@msgpack/msgpack'
import { deflate as pakoCompress, inflate as pakoDecompress } from 'pako'

function binaryToPNG(data: Uint8Array): Uint8Array {
    const width = 512
    const height = Math.ceil((data.length + 4) / 3 / width)
    const channels = 3
    const length = width * height * channels

    const buf = new Uint8Array(length)
    buf.set(data, 0)
    return PNGEncode({
        data: buf,
        channels: 3,
        height: Math.ceil((data.length + 4) / 3 / 512),
        width: 512
    })
}

function binaryFromPNG(data: Uint8Array, length: number): Uint8Array {
    const buf = PNGDecode(data, { 'checkCrc': true }).data
    return buf.slice(buf.byteOffset, buf.byteOffset + length) as Uint8Array
}

async function arrayBufferToBase64(bytes: Uint8Array): Promise<string> {
    const base64url: string = await new Promise(r => {
        const reader = new FileReader()
        reader.onload = () => r(reader.result as string)
        reader.readAsDataURL(new Blob([bytes]))
    })

    return base64url.split(",", 2)[1]
}

async function arrayBufferFromBase64(base64: string): Promise<Uint8Array> {
    const base64url = `data:application/octet-binary;base64,${base64}`
    const bytes = await fetch(base64url)

    return new Uint8Array(await bytes.arrayBuffer())
}

export async function PNGCompress(data: Uint8Array, name: string): Promise<HTMLImageElement> {
    const compressed = pakoCompress(msgpackEncode(data))
    const png = binaryToPNG(compressed)
    const b64 = await arrayBufferToBase64(png)
    const element = document.createElement('img')
    element.id = `_local--${name}`
    element.decoding = 'async'
    element.loading = 'eager'
    element.src = `data:image/png;base64,${b64}`
    element.setAttribute('data-length', compressed.length.toString())
    element.style.display = 'none'
    return element
}

export async function PNGDecompress(id: string): Promise<Object> {
    const element = document.getElementById(id) as HTMLImageElement
    const png = await arrayBufferFromBase64(element.src.split(',', 2)[1])
    const compressed = binaryFromPNG(png, Number(element.getAttribute('data-length')))
    return msgpackDecode(pakoDecompress(compressed))
}