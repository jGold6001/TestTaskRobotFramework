# RobotFramework test task

Solution deploying using **Windows 10** and **Chrome 87.0.4280.88** 
**{path_to_python_script_folder}** - ".../Python/Python39/Scripts" 
{path_to_python_script_folder} add to **Environment Variables -> System variables -> Path** 


### Tech 
* Python 3.9
* Selenium 3.141.0.
* Robotframework 3.2.2
* Robotframework Seleniumlibrary 4.5.0

### Installation

```sh
$ pip install selenium
$ pip install robotframework
$ pip install robotframework-seleniumlibrary
$ curl 'https://chromedriver.storage.googleapis.com/87.0.4280.88/chromedriver_win32.zip' -o {path_to_folder}/chromedriver_win32.zip
$ unzip {path_to_folder}/chromedriver_win32.zip  -d {path_to_python_script_folder}
```

#### Build And Run
For production release:
```sh
$ robot Main.robot
```

