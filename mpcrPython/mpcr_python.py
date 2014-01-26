import urllib
import urllib2
import httplib
import time

MPC_HC_HOST = "192.168.1.101"   # Host pc where the player is working
MPC_HC_PORT = "13579"           # Default port
MPC_HC_PAGE = "/command.html"   # Page for command
MPC_HC_URL = "{0}:{1}".format(MPC_HC_HOST, MPC_HC_PORT)
headers = {"Content-type": "application/x-www-form-urlencoded"}

def player_play():
    command = {
        'wm_command' : 887
}
    data = urllib.urlencode(command)
    h = httplib.HTTPConnection(MPC_HC_URL)
    h.request('POST', MPC_HC_PAGE, data, headers)


def player_stop():
    command = {
        'wm_command' : 888
}
    data = urllib.urlencode(command)
    h = httplib.HTTPConnection(MPC_HC_URL)
    h.request('POST', MPC_HC_PAGE, data, headers)
    r = h.getresponse()

player_play()
time.sleep(2)
player_stop()



