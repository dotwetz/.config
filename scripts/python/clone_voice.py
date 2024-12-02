import requests

response = requests.post(
    "https://api.fish.audio/model",
    files=[
        ("voices", open("hello.mp3", "rb")),
        ("voices", open("test.wav", "rb")),
    ],
    data=[
        ("visibility", "private"),
        ("type", "tts"),
        ("title", "Demo"),
        ("train_mode", "fast"),
        # Enhance audio quality will remove background noise
        ("enhance_audio_quality", "true"),
        # Texts are optional, but if you provide them, they must match the number of audio samples
        ("texts", "text1"),
        ("texts", "text2"),
    ],
    headers={
        "Authorization": "Bearer YOUR_API_KEY",
    },
)

print(response.json())
