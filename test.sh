curl -F 'client_id=b3481714257943a4974e4e7ba99eb357' \
     -F 'client_secret=424e2760ecfb4a6e9be301257d401a80' \
     -F 'object=geography' \
     -F 'aspect=media' \
     -F 'lat=37.779669924659004' \
     -F 'lng=-122.16796875000006' \
     -F 'radius=5000' \
     -F 'verify_token=myVerifyToken' \
     -F 'callback_url=http://4ggv.localtunnel.com/api/subscription' \
     https://api.instagram.com/v1/subscriptions/