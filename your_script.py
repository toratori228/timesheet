import requests

def main():
    # A sample URL to make a GET request
    url = "https://jsonplaceholder.typicode.com/posts/1"
    
    # Making a GET request to the sample API
    response = requests.get(url)
    
    if response.status_code == 200:
        # Printing the JSON response if the request was successful
        data = response.json()
        print("Title:", data['title'])
        print("Body:", data['body'])
    else:
        print(f"Failed to retrieve data. Status code: {response.status_code}")

if __name__ == "__main__":
    main()

