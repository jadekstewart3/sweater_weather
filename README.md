# Sweater Weather

## Table of Contents
  - [Overview](#overview)
  - [Built With](#built-with)
  - [Learning Goals](#learning-goals)
  - [Getting Started](#getting-started)
  - [Endpoints](#endpoints)

  ### Overview
  Sweater Weather is a Rails API that consumes multiple third party API's to provide weather data for a destination that a person is travelling to. Requests and responses are in JSON format.

  ### Built With
  ![Ruby 3.1.1](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
  - Ruby 3.1.1
  - Rails 7.0.4

  ### Learning Goals
  - Expose an API that aggregates data from multiple external APIs
  - Expose an API that requires an authentication token
  - Expose an API for CRUD functionality
  - Determine completion criteria based on the needs of other developers
  - Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc)

  ### Getting Started 

    `% git clone https://github.com/jadekstewart3/sweater_weather.git`
    `% cd sweater_weather`
    `% rails db:{create, migrate}`
    `% bundle exec figaro install`

  ### You will need to sign up for API KEYS and set them as ENV variables in the config/application.yml file from the following:
    - [MapQuest's API]( https://developer.mapquest.com/documentation/)
    - [Weather API](https://www.weatherapi.com/)

### Endpoints

---


---
<details>
  <summary>GET: Forecast</summary>

  <br>

Request:

  ```JS
  POST /api/v0/forecast?location=denver,co
  ```
  Params: 
   | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `location` | Required | string | Current Location
  
<br>
 Response: 

  | Result | Status |
  | ------- | ------| 
  | `Success` | 201 |
  | `Failure`| 400 |

  ```JSON
  {
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "last_updated": "2023-04-23 18:30",
                "temperature": 53.1,
                "feels_like": 50.3,
                "humidity": 28,
                "uv_index": 4.0,
                "visibility": 9.0,
                "description": "Partly cloudy",
                "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
            },
            "daily_weather": [
                {
                    "date": "2023-04-23",
                    "sunrise": "06:11 AM",
                    "sunset": "07:46 PM",
                    "max_temp": 58.6,
                    "min_temp": 32.4,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "date": "2023-04-24",
                    "sunrise": "06:10 AM",
                    "sunset": "07:47 PM",
                    "max_temp": 65.8,
                    "min_temp": 41.5,
                    "description": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                },
                {
                    "date": "2023-04-25",
                    "sunrise": "06:08 AM",
                    "sunset": "07:48 PM",
                    "max_temp": 56.1,
                    "min_temp": 42.1,
                    "description": "Heavy rain",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/308.png"
                },
                {
                    "date": "2023-04-26",
                    "sunrise": "06:07 AM",
                    "sunset": "07:49 PM",
                    "max_temp": 45.7,
                    "min_temp": 33.4,
                    "description": "Heavy rain",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/308.png"
                },
                {
                    "date": "2023-04-27",
                    "sunrise": "06:06 AM",
                    "sunset": "07:50 PM",
                    "max_temp": 66.4,
                    "min_temp": 36.5,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                }
            ],
            "hourly_weather": [
                {
                    "time": "06:00",
                    "temperature": 36.5,
                    "description": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
                },
                {
                    "time": "07:00",
                    "temperature": 36.0,
                    "description": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
                },
                {
                    "time": "08:00",
                    "temperature": 35.8,
                    "description": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "09:00",
                    "temperature": 34.5,
                    "description": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "10:00",
                    "temperature": 34.0,
                    "description": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "11:00",
                    "temperature": 33.3,
                    "description": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "12:00",
                    "temperature": 32.4,
                    "description": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "13:00",
                    "temperature": 34.0,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "14:00",
                    "temperature": 36.3,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "15:00",
                    "temperature": 39.6,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "16:00",
                    "temperature": 43.2,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "17:00",
                    "temperature": 48.4,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "18:00",
                    "temperature": 51.6,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "19:00",
                    "temperature": 54.5,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "20:00",
                    "temperature": 56.8,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "21:00",
                    "temperature": 58.5,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "22:00",
                    "temperature": 58.6,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "23:00",
                    "temperature": 58.1,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "00:00",
                    "temperature": 57.9,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "01:00",
                    "temperature": 56.7,
                    "description": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                {
                    "time": "02:00",
                    "temperature": 52.0,
                    "description": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "03:00",
                    "temperature": 50.0,
                    "description": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "04:00",
                    "temperature": 48.7,
                    "description": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "05:00",
                    "temperature": 48.0,
                    "description": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                }
            ]
        }
    }
}
```
</details>

<details>
<summary>POST: Register a User</summary>

  Request:
  
  ```JSON
  POST "/api/v0/users"
  ```

  Params: 
  | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `email` | Required | string | User email
  | `password` | Required | string | User password
  | `password_confirmation` | Required | string | User password

  <i> Note: All params are REQUIRED </i>

  <br>

  Response: 

  | Result | Status |
  | ------- | ------| 
  | `Success` | 201 |
  | `Failure`| 401 |

  ```JSON
  {
    "data": {
        "id": "2",
        "type": "user",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "SJjgKFElfAeRMJ7332bn4Qtt"
        }
    }
}
```
</details>

<details>

  <summary>POST: Login a User</summary>

  <br>
  Request: 
  
  ```JSON
  POST /api/v0/sessions
  ```
  Params: 

  | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `email` | Required | string | User email
  | `password` | Required | string | User password

  Response: 

  | Result | Status |
  | ------- | ------| 
  | `Success` | 201 |
  | `Failure`| 401 |

  ```JSON
  {
    "data": {
        "id": "158",
        "type": "user",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "b0OfVejwe9g2rFR0ii9ARwtt"
        }
    }
}
```
</details>

<details>
  <summary>GET: City Salaries</summary>
  <br>
  Request:

  ```JSON
  GET /api/v0/salaries?destination=denver
  ```

  Params: 

  | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `destination` | Required | string | User input

  Response: 

  | Result | Status |
  | ------- | ------| 
  | `Success` | 201 |
  | `Failure`| 401 |

  ```JSON
  {
    "data": {
        "id": null,
        "type": "salaries",
        "attributes": {
            "destination": "denver",
            "forecast": {
                "summary": "Moderate or heavy rain with thunder",
                "temperature": "43 F"
            },
            "salaries": [
                {
                    "title": "Data Analyst",
                    "min": "$42878.34",
                    "max": "$62106.69"
                },
                {
                    "title": "Data Scientist",
                    "min": "$74686.72",
                    "max": "$108990.21"
                },
                {
                    "title": "Mobile Developer",
                    "min": "$69999.26",
                    "max": "$109493.37"
                },
                {
                    "title": "QA Engineer",
                    "min": "$56250.12",
                    "max": "$85478.12"
                },
                {
                    "title": "Software Engineer",
                    "min": "$64514.46",
                    "max": "$95843.57"
                },
                {
                    "title": "Systems Administrator",
                    "min": "$53889.29",
                    "max": "$78055.83"
                },
                {
                    "title": "Web Developer",
                    "min": "$51218.22",
                    "max": "$78639.07"
                }
            ]
        }
    }
}
```
</details>

<details>
  <summary>POST: Road Trip</summary>
  <br>
  Request:

  ```JSON
  POST /api/v0/road_trip
  ```

  Params: 

  | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `origin` | Required | string | User input
  | `destination` | Required | string | User input
  | `api_key` | Required | string | User param

  Response: 

  | Result | Status |
  | ------- | ------| 
  | `Success` | 201 |
  | `Failure`| 401 |

  ```JSON
  {
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinnati, OH",
            "end_city": "Chicago, IL",
            "travel_time": "04:40:45",
            "weather_at_eta": {
                "datetime": "2023-04-25 19:00",
                "temperature": 41.9,
                "condition": "Sunny"
            }
        }
    }
}
```
</details>