-- CreateEnum
CREATE TYPE "CenterStatus" AS ENUM ('pending', 'rejected', 'activated');

-- CreateEnum
CREATE TYPE "TeacherStatus" AS ENUM ('active', 'inactive');

-- CreateTable
CREATE TABLE "Admin" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Center" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "document" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "regionId" INTEGER NOT NULL,
    "image" TEXT NOT NULL,
    "status" "CenterStatus" NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "Center_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Teacher" (
    "id" SERIAL NOT NULL,
    "fullname" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "sertificate" TEXT NOT NULL,
    "status" "TeacherStatus" NOT NULL,
    "image" TEXT NOT NULL,
    "centerId" INTEGER NOT NULL,

    CONSTRAINT "Teacher_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Group" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "teacherId" INTEGER NOT NULL,
    "startTime" TIMESTAMP(3) NOT NULL,
    "endTime" TIMESTAMP(3) NOT NULL,
    "avarageScore" DOUBLE PRECISION NOT NULL,
    "checkerTeacherId" INTEGER NOT NULL,

    CONSTRAINT "Group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Student" (
    "id" SERIAL NOT NULL,
    "fullname" TEXT NOT NULL,
    "groupId" INTEGER NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT NOT NULL,

    CONSTRAINT "Student_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Exam" (
    "id" SERIAL NOT NULL,
    "readingVariantId" INTEGER NOT NULL,
    "writingVariantId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,

    CONSTRAINT "Exam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Region" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Region_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Result" (
    "id" SERIAL NOT NULL,
    "examId" INTEGER NOT NULL,
    "speakingScore" INTEGER NOT NULL,
    "writingScore" INTEGER NOT NULL,
    "listeningScore" INTEGER NOT NULL,
    "readingScore" INTEGER NOT NULL,
    "examenarTeacherId" INTEGER NOT NULL,
    "speakingComment" TEXT NOT NULL,
    "writingComment" TEXT NOT NULL,

    CONSTRAINT "Result_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReadingVariant" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "ReadingVariant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReadingBlok" (
    "id" SERIAL NOT NULL,
    "blockName" TEXT NOT NULL,
    "readingVariantId" INTEGER NOT NULL,

    CONSTRAINT "ReadingBlok_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReadingQuestion" (
    "id" SERIAL NOT NULL,
    "questionText" TEXT NOT NULL,
    "readingBlockId" INTEGER NOT NULL,

    CONSTRAINT "ReadingQuestion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WritingVariant" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "WritingVariant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WritingBlok" (
    "id" SERIAL NOT NULL,
    "blockName" TEXT NOT NULL,
    "writingVariantId" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "image" TEXT NOT NULL,

    CONSTRAINT "WritingBlok_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Center_email_key" ON "Center"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Teacher_email_key" ON "Teacher"("email");

-- AddForeignKey
ALTER TABLE "Center" ADD CONSTRAINT "Center_regionId_fkey" FOREIGN KEY ("regionId") REFERENCES "Region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Teacher" ADD CONSTRAINT "Teacher_centerId_fkey" FOREIGN KEY ("centerId") REFERENCES "Center"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Group" ADD CONSTRAINT "Group_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "Teacher"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Group" ADD CONSTRAINT "Group_checkerTeacherId_fkey" FOREIGN KEY ("checkerTeacherId") REFERENCES "Teacher"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Student" ADD CONSTRAINT "Student_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exam" ADD CONSTRAINT "Exam_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Student"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exam" ADD CONSTRAINT "Exam_readingVariantId_fkey" FOREIGN KEY ("readingVariantId") REFERENCES "ReadingVariant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exam" ADD CONSTRAINT "Exam_writingVariantId_fkey" FOREIGN KEY ("writingVariantId") REFERENCES "WritingVariant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Result" ADD CONSTRAINT "Result_examId_fkey" FOREIGN KEY ("examId") REFERENCES "Exam"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Result" ADD CONSTRAINT "Result_examenarTeacherId_fkey" FOREIGN KEY ("examenarTeacherId") REFERENCES "Teacher"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReadingBlok" ADD CONSTRAINT "ReadingBlok_readingVariantId_fkey" FOREIGN KEY ("readingVariantId") REFERENCES "ReadingVariant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReadingQuestion" ADD CONSTRAINT "ReadingQuestion_readingBlockId_fkey" FOREIGN KEY ("readingBlockId") REFERENCES "ReadingBlok"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WritingBlok" ADD CONSTRAINT "WritingBlok_writingVariantId_fkey" FOREIGN KEY ("writingVariantId") REFERENCES "WritingVariant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
