#include <fcntl.h>           /* For O_* constants */
#include <sys/stat.h>        /* For mode constants */
#include <mqueue.h>
#include <unistd.h>
#include <stdio.h>

#define NAME "/xxx"

int
main(void)
{
  mqd_t t = mq_open(NAME, O_CREAT|O_RDWR, S_IRUSR|S_IWUSR, NULL);;
  if ((mqd_t)t == -1)
    {
      perror("open[" NAME "]");
      return 1;
    }

  printf("pid: %d / fd: %d\n", getpid(), t);
  fflush(stdout);
  pause();
  return 0;
}
