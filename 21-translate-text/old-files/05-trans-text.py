# 출처: https://blockdmask.tistory.com/540 [개발자 지망생]
import googletrans
translator = googletrans.Translator()

orgen="This book is designed to develop both server and client for an application."
strko=translator.translate(orgen, dest='ko')
print(f"[1m[31mfrom[1m[32m {orgen}")
print(f"[1m[31mto  [1m[33m {strko.text}")
orgen="We have used the Kotlin language for both the server and client sides."
strko=translator.translate(orgen, dest='ko')
print(f"[1m[31mfrom[1m[32m {orgen}")
print(f"[1m[31mto  [1m[33m {strko.text}")
orgen="In this book, Spring will be the server-side application, and Android the client-side application."
strko=translator.translate(orgen, dest='ko')
print(f"[1m[31mfrom[1m[32m {orgen}")
print(f"[1m[31mto  [1m[33m {strko.text}")
orgen="Our primary focus is on those areas that will be able to help a developer develop a secure application with the latest architecture."
strko=translator.translate(orgen, dest='ko')
print(f"[1m[31mfrom[1m[32m {orgen}")
print(f"[1m[31mto  [1m[33m {strko.text}")
orgen="This book describes the basics of Kotlin and Spring, which will be of benefit if you are unfamiliar with these platforms."
strko=translator.translate(orgen, dest='ko')
print(f"[1m[31mfrom[1m[32m {orgen}")
print(f"[1m[31mto  [1m[33m {strko.text}")
orgen="We also designed the chapters for implementing security and database in a project."
strko=translator.translate(orgen, dest='ko')
print(f"[1m[31mfrom[1m[32m {orgen}")
print(f"[1m[31mto  [1m[33m {strko.text}")
orgen="This book delves into the use of Retrofit for handling HTTP requests and SQLite Room for storing data in an Android device."
strko=translator.translate(orgen, dest='ko')
print(f"[1m[31mfrom[1m[32m {orgen}")
print(f"[1m[31mto  [1m[33m {strko.text}")
orgen="You will also be able to find a way of how to develop a robust, reactive project."
strko=translator.translate(orgen, dest='ko')
print(f"[1m[31mfrom[1m[32m {orgen}")
print(f"[1m[31mto  [1m[33m {strko.text}")
orgen="Then, you will learn how to test a project using JUnit and Espresso for developing a less bug-prone and stable project."
strko=translator.translate(orgen, dest='ko')
print(f"[1m[31mfrom[1m[32m {orgen}")
print(f"[1m[31mto  [1m[33m {strko.text}")
print(f"[1m[36m----> ok[1m(B[m")
