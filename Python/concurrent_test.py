import concurrent.futures
import requests
import threading
import time


thread_local = threading.local()


def get_session():
    if not hasattr(thread_local, "session"):
        thread_local.session = requests.Session()
    return thread_local.session


for E in E_:
    for t in t_:
        for w in Omega_:
            o_1.append((((1)/(w**3 + w))* (( (exp(-1*1j*w*t)) - 1) / (1 - exp(-1*w)) ).real)*dx)
        o_2.append(exp(sum(o_1) + 1j*E*t)*dx)
        o_1 = []
    print(f"E: {E}")
    outputs.append(sum(o_2))
    o_2 = []
    
def download_site(url):
    session = get_session()
    with session.get(url) as response:
        print(f"Read {len(response.content)} from {url}")


def download_all_sites(sites):
    with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        executor.map(download_site, sites)


if __name__ == "__main__":
    sites = [
        "https://www.jython.org",
        "http://olympus.realpython.org/dice",
    ] * 80
    start_time = time.time()
    download_all_sites(sites)
    duration = time.time() - start_time
    print(f"Downloaded {len(sites)} in {duration} seconds")