import asyncio
from aiogram import Bot, Dispatcher, types
from aiogram.filters import Command
import yt_dlp
import os

API_TOKEN = '8834271734:AAEaFLuYIqyluV-zqeYdKYzHBEgYLuegvjQ'

bot = Bot(token=API_TOKEN)
dp = Dispatcher()

@dp.message(Command("start"))
async def start(message: types.Message):
    await message.answer("سلاڤ! ب خێر بێی بۆ بۆتا من.")

@dp.message()
async def handle_message(message: types.Message):
    url = message.text
    if "tiktok" in url or "instagram" in url or "snap" in url:
        await message.answer("جاوەڕێ بە، ئەز دێ ڤیدیویێ دابەزینم...")
        try:
            ydl_opts = {'format': 'best', 'outtmpl': 'video.mp4'}
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                ydl.download([url])
            await message.answer_video(video=types.FSInputFile("video.mp4"), caption="MADE BY @YUSSEF_SURCHI")
            os.remove("video.mp4")
        except Exception as e:
            await message.answer(f"ئاریشەک پەیدا بوو: {e}")
    else:
        await message.answer("تکایە لینکەکێ دروست بنڤیسە.")

async def main():
    await dp.start_polling(bot)

if __name__ == "__main__":
    asyncio.run(main())
