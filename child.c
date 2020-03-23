// Output: child
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>


typedef struct {
    int num;
    char name[10];
    double grade;
} stud;

// Child process:
// - outputs the information obtained from the parent process
// - edit's the created by parent process file - i.e. sets a new average
// grade of the student
// - finishes work
int main(int argc, char *argv[]) {

	int number = strtol(argv[1], NULL, 10);
	char *name = argv[2];
	double grade = strtod(argv[3], NULL);

	printf("Student's card number: %d\n", number);
	printf("Student's name: %s\n", name);
	printf("New average grade: %lf\n", grade);

	rename("data.bin", "dataold.bin");

	FILE *fwrite_ptr, *fread_ptr;
	fwrite_ptr = fopen("data.bin", "wb");
	fread_ptr = fopen("dataold.bin", "rb");

	while(1) {
		stud tmp;
		int i = fread(&tmp, sizeof tmp, 1, fread_ptr);
		if (i == 0) {
			break;
		}
		if (tmp.num == number && !strcmp(tmp.name, name)) {
			tmp.grade = grade;
		}
		fwrite(&tmp, sizeof tmp, 1, fwrite_ptr);
	}
	fclose(fread_ptr);
	fclose(fwrite_ptr);

	sleep(3);


	return 0;
}