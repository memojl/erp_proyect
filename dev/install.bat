ECHO OFF
:Menu
cls
ECHO "MENU"
ECHO "Seleccione el numero de la opcion:"
ECHO "1. Install"
ECHO "2. Preview"
ECHO "3. Migrate"
ECHO "4. SuperUsuario"
ECHO "5. Cors"
ECHO "6. Exit"
set /p var=
if %var%==1 goto :Install
if %var%==2 goto :Preview
if %var%==3 goto :Migrate
if %var%==4 goto :Super
if %var%==5 goto :Cors
if %var%==6 goto :Exit

:Preview
start Chrome.exe http://127.0.0.1:8000
CALL python manage.py runserver

:Migrate
CALL python manage.py makemigrations
ECHO --
CALL python manage.py migrate
ECHO "migrate --> Ok"
GOTO :Menu

:Super
ECHO "CREAR SUPER USUARIO"
CALL python manage.py createsuperuser
ECHO "createsuperuser --> Ok"
GOTO :Preview

:Cors
ECHO "INSTALANDO CORS HEADERS"
CALL pip install django-cors-headers
ECHO "django-cors-headers --> Ok"
ECHO --
ECHO "Agregar: INSTALLED_APPS = ['corsheaders']"
ECHO "MIDDLEWARE = ['corsheaders.middleware.CorsMiddleware']"
ECHO "CORS_ALLOWED_ORIGINS = ['dominio']"
PAUSE
GOTO :Menu

:Exit
ECHO "Desea Salir del Menu [y/N]"
set /p var2=
if %var2%==y goto :Bye
if %var2%==n goto :Menu

:Install
cls
ECHO "Desea instalar virtualenv [y/N]"
set /p var3=
if %var3%==y goto :Ins
if %var3%==n goto :Continue

:Ins
CALL pip install virtualenv
ECHO --
GOTO :Continue 

:Continue
ECHO "CREAR ENTORNO VIRTUAL"
CALL python -m virtualenv venv
ECHO "virtualenv --> Ok"
ECHO --
CALL .\venv\Scripts\activate
ECHO "virtualenv --> Activado"
ECHO --
CALL pip list
ECHO "Desea actualizar pip [y/N]"
set /p var4=
if %var4%==y goto :Updatepip
if %var4%==n goto :Instalar

:Updatepip
CALL python.exe -m pip install --upgrade pip
ECHO "pip actualizado --> Ok"
ECHO --
ECHO "Antes de continuar seleccione el 'Interprete' en VSCode."
ECHO --
PAUSE
GOTO :Instalar

:Instalar
cls
ECHO "INSTALAR DJANGO"
CALL pip install django
ECHO "django --> Ok"
ECHO --
ECHO "INSTALAR DJANGO REST FRAMEWORK"
CALL pip install djangorestframework
ECHO "django rest framework --> Ok"
ECHO --
ECHO "CREAR PROYECTO"
CALL django-admin startproject proyectoDJ .
ECHO "proyecto --> Ok"
ECHO --
ECHO "CREAR APP-API"
CALL python manage.py startapp api
ECHO "api --> Ok"
CALL git add .
ECHO "Instalacion completa --> 100"
ECHO --
ECHO "Agregar 'api' y 'rest_framework' en proyectoDJ/settings.py"
ECHO "INSTALLED_APPS = ['rest_framework','api']"
ECHO "Crear Modelo y Admin"
PAUSE 
CALL python manage.py makemigrations
ECHO --
CALL python manage.py migrate
ECHO "migrate --> Ok"
ECHO --
GOTO :Super

:Bye
PAUSE