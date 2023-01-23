

## 2 x Samsung 9a3 pci 4.0 (aoc supermicro card x4) iouring raid0 xfs
```bash
root@valkyria1:/var/lib/scylla# fio --name TEST --eta-newline=5s --filename=fio-tempfile.dat --rw=randread --size=500m --io_size=10g --blocksize=4k --ioengine=io_uring --fsync=1 --iodepth=1 --direct=1 --numjobs=1 --runtime=60 --group_reporting
TEST: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=1
fio-3.28
Starting 1 process
Jobs: 1 (f=1): [r(1)][11.7%][r=53.1MiB/s][r=13.6k IOPS][eta 00m:53s]
Jobs: 1 (f=1): [r(1)][21.7%][r=55.3MiB/s][r=14.2k IOPS][eta 00m:47s] 
Jobs: 1 (f=1): [r(1)][31.7%][r=53.2MiB/s][r=13.6k IOPS][eta 00m:41s] 
Jobs: 1 (f=1): [r(1)][41.7%][r=53.3MiB/s][r=13.6k IOPS][eta 00m:35s] 
Jobs: 1 (f=1): [r(1)][51.7%][r=55.2MiB/s][r=14.1k IOPS][eta 00m:29s] 
Jobs: 1 (f=1): [r(1)][61.7%][r=56.6MiB/s][r=14.5k IOPS][eta 00m:23s] 
Jobs: 1 (f=1): [r(1)][71.7%][r=52.9MiB/s][r=13.5k IOPS][eta 00m:17s] 
Jobs: 1 (f=1): [r(1)][81.7%][r=57.0MiB/s][r=14.6k IOPS][eta 00m:11s] 
Jobs: 1 (f=1): [r(1)][91.7%][r=55.8MiB/s][r=14.3k IOPS][eta 00m:05s] 
Jobs: 1 (f=1): [r(1)][100.0%][r=52.9MiB/s][r=13.5k IOPS][eta 00m:00s]
TEST: (groupid=0, jobs=1): err= 0: pid=2715: Mon Jan 23 21:03:25 2023
  read: IOPS=14.0k, BW=54.6MiB/s (57.2MB/s)(3274MiB/60001msec)
    slat (nsec): min=640, max=384804, avg=1378.92, stdev=1741.53
    clat (nsec): min=180, max=2036.7k, avg=69706.06, stdev=8966.47
     lat (usec): min=62, max=2041, avg=71.14, stdev= 9.22
    clat percentiles (usec):
     |  1.00th=[   63],  5.00th=[   63], 10.00th=[   63], 20.00th=[   64],
     | 30.00th=[   67], 40.00th=[   68], 50.00th=[   68], 60.00th=[   69],
     | 70.00th=[   74], 80.00th=[   77], 90.00th=[   78], 95.00th=[   79],
     | 99.00th=[   82], 99.50th=[   90], 99.90th=[  119], 99.95th=[  221],
     | 99.99th=[  396]
   bw (  KiB/s): min=53696, max=58544, per=100.00%, avg=55925.51, stdev=1798.02, samples=119
   iops        : min=13424, max=14636, avg=13981.38, stdev=449.51, samples=119
  lat (nsec)   : 250=0.01%, 500=0.01%, 750=0.01%
  lat (usec)   : 4=0.01%, 20=0.01%, 50=0.01%, 100=99.69%, 250=0.26%
  lat (usec)   : 500=0.04%, 750=0.01%, 1000=0.01%
  lat (msec)   : 4=0.01%
  cpu          : usr=1.54%, sys=5.30%, ctx=838198, majf=0, minf=12
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=838120,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=54.6MiB/s (57.2MB/s), 54.6MiB/s-54.6MiB/s (57.2MB/s-57.2MB/s), io=3274MiB (3433MB), run=60001-60001msec

Disk stats (read/write):
    md0: ios=836698/0, merge=0/0, ticks=51308/0, in_queue=51308, util=99.91%, aggrios=419060/0, aggrmerge=0/0, aggrticks=26122/0, aggrin_queue=26122, aggrutil=99.88%
  nvme2n1: ios=419092/0, merge=0/0, ticks=26124/0, in_queue=26125, util=99.88%
  nvme1n1: ios=419028/0, merge=0/0, ticks=26120/0, in_queue=26120, util=99.88%
root@valkyria1:/var/lib/scylla# 
```

## 2 x Samsung 1733 pci 4.0 (aoc supermicro card x4) iouring raid0 ext4
```bash

rickard@valkyria3:/var$ fio --name TEST --eta-newline=5s --filename=fio-tempfile.dat --rw=randread --size=500m --io_size=10g --blocksize=4k --ioengine=libaio --fsync=1 --iodepth=1 --direct=1 --numjobs=1 --runtime=60 --group_reporting 
TEST: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=1
fio-3.28
Starting 1 process
Jobs: 1 (f=1): [r(1)][11.7%][r=50.4MiB/s][r=12.9k IOPS][eta 00m:53s]
Jobs: 1 (f=1): [r(1)][21.7%][r=51.4MiB/s][r=13.2k IOPS][eta 00m:47s] 
Jobs: 1 (f=1): [r(1)][31.7%][r=53.3MiB/s][r=13.7k IOPS][eta 00m:41s] 
Jobs: 1 (f=1): [r(1)][41.7%][r=55.3MiB/s][r=14.2k IOPS][eta 00m:35s] 
Jobs: 1 (f=1): [r(1)][51.7%][r=53.6MiB/s][r=13.7k IOPS][eta 00m:29s] 
Jobs: 1 (f=1): [r(1)][61.7%][r=55.4MiB/s][r=14.2k IOPS][eta 00m:23s] 
Jobs: 1 (f=1): [r(1)][71.7%][r=50.3MiB/s][r=12.9k IOPS][eta 00m:17s] 
Jobs: 1 (f=1): [r(1)][81.7%][r=50.1MiB/s][r=12.8k IOPS][eta 00m:11s] 
Jobs: 1 (f=1): [r(1)][91.7%][r=52.2MiB/s][r=13.4k IOPS][eta 00m:05s] 
Jobs: 1 (f=1): [r(1)][100.0%][r=55.3MiB/s][r=14.2k IOPS][eta 00m:00s]
TEST: (groupid=0, jobs=1): err= 0: pid=2256: Mon Jan 23 21:04:08 2023
  read: IOPS=13.4k, BW=52.5MiB/s (55.1MB/s)(3152MiB/60001msec)
    slat (nsec): min=2675, max=49342, avg=4340.21, stdev=1559.48
    clat (usec): min=27, max=366, avg=69.18, stdev= 7.59
     lat (usec): min=29, max=372, avg=73.64, stdev= 8.10
    clat percentiles (usec):
     |  1.00th=[   62],  5.00th=[   62], 10.00th=[   62], 20.00th=[   63],
     | 30.00th=[   64], 40.00th=[   65], 50.00th=[   67], 60.00th=[   67],
     | 70.00th=[   78], 80.00th=[   79], 90.00th=[   82], 95.00th=[   82],
     | 99.00th=[   82], 99.50th=[   83], 99.90th=[   87], 99.95th=[   92],
     | 99.99th=[  105]
   bw (  KiB/s): min=51176, max=56736, per=100.00%, avg=53814.32, stdev=2459.49, samples=119
   iops        : min=12794, max=14184, avg=13453.60, stdev=614.86, samples=119
  lat (usec)   : 50=0.05%, 100=99.93%, 250=0.03%, 500=0.01%
  cpu          : usr=2.47%, sys=9.68%, ctx=806990, majf=0, minf=12
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=806984,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=52.5MiB/s (55.1MB/s), 52.5MiB/s-52.5MiB/s (55.1MB/s-55.1MB/s), io=3152MiB (3305MB), run=60001-60001msec

Disk stats (read/write):
    md0: ios=805452/70, merge=0/0, ticks=53324/0, in_queue=53324, util=99.91%, aggrios=0/0, aggrmerge=0/0, aggrticks=0/0, aggrin_queue=0, aggrutil=0.00%
  nvme2n1: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
  nvme1n1: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
```
