apiVersion: apps/v2beta1
kind: Deployment
metadata:
  creationTimestamp: 2019-07-16T11:47:34Z
  generation: 1
  labels:
    run: nginx1
  name: nginx1
  namespace: default
  resourceVersion: "41656"
  selfLink: /apis/apps/v1beta1/namespaces/default/deployments/nginx1
  uid: 8055368e-a7bf-11e9-8a71-5254008afee6
spec:
  progressDeadlineSeconds: 600
  replicas: 4
  revisionHistoryLimit: 2
  selector:
    matchLabels:
      run: nginx1
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        run: nginx1
    spec:
      containers:
      - image: mincloud1501/nginx
        imagePullPolicy: Always
        name: nginx1
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status: {}