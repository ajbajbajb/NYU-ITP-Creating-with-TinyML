
import asyncio
from bleak import BleakClient

address = "08D50911-90FC-4300-993A-E28AD1FE2BA2"
MODEL_NBR_UUID = "Arduino"

async def main(address):
    async with BleakClient(address) as client:
        model_number = await client.read_gatt_char(MODEL_NBR_UUID)
        print("Model Number: {0}".format("".join(map(chr, model_number))))

asyncio.run(main(address))
