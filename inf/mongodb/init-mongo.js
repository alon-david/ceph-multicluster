db.CreateUser(
    {
        user: "ceph",
        pwd: "ceph",
        roles: [
            {
                role: "readWrite",
                db: "ceph-multicluster"
            }
        ]
    }
)